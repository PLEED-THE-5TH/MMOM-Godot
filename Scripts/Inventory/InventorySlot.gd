extends AspectRatioContainer

class_name InventorySlot

var item_stack_ui: ItemStackUI:
	get:
		return item_stack_ui

func init(item_stack: ItemStack) -> void:
	item_stack_ui = $"Item Stack"
	item_stack_ui.init(item_stack)

func _gui_input(event: InputEvent) -> void:
	var mouse_button_event: InputEventMouseButton = event as InputEventMouseButton
	
	if not mouse_button_event or not mouse_button_event.pressed:
		return
	
	match mouse_button_event.button_index:
		MOUSE_BUTTON_LEFT:
			_handle_left_click()
		MOUSE_BUTTON_RIGHT:
			_handle_right_click()

func _handle_left_click() -> void:
	var held_stack: ItemStack = Player.singleton.held_stack
	var item_stack: ItemStack = item_stack_ui.item_stack
	
	if held_stack.is_empty():
		if item_stack.is_empty():
			return
		
		held_stack.set_stack(item_stack)
		item_stack.empty()
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
	
	var single_stack = ItemStack.new(held_stack.item)
	if not item_stack.combine(single_stack, true):
		return
	
	held_stack.increment_size(-1)
