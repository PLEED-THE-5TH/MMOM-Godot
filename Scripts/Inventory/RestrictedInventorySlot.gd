extends InventorySlot

class_name RestrictedInventorySlot

var restrict_type: Variant:
	get:
		return restrict_type

func init(item_stack: ItemStack, init_restrict_type: Variant = Item) -> void:
	super(item_stack)
	restrict_type = init_restrict_type

func _handle_left_click() -> void:
	var held_stack: ItemStack = Player.singleton.held_stack
	var item_stack: ItemStack = item_stack_ui.item_stack
	
	if held_stack.is_empty():
		if item_stack.is_empty():
			return
		
		held_stack.set_stack(item_stack)
		item_stack.empty()
		return
	
	if not is_instance_of(held_stack.item, restrict_type):
		return
	
	if not item_stack.combine(held_stack, true) and item_stack.items_conflict(held_stack):
		var temp: ItemStack = held_stack.clone()
		held_stack.set_stack(item_stack)
		item_stack.set_stack(temp)

func _handle_right_click() -> void:
	var held_stack: ItemStack = Player.singleton.held_stack
	var item_stack: ItemStack = item_stack_ui.item_stack
	
	if held_stack.is_empty():
		@warning_ignore("integer_division")
		var half_size: int = item_stack.size / 2
		if not item_stack.increment_size(-half_size):
			return
		
		held_stack.set_item_and_size(item_stack.item, half_size)
		return
	
	if not is_instance_of(held_stack.item, restrict_type):
		return
	
	var single_stack = ItemStack.new(held_stack.item)
	if not item_stack.combine(single_stack, true):
		return
	
	held_stack.increment_size(-1)
