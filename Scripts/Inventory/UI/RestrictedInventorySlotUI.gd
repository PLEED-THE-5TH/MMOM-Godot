extends InventorySlotUI

class_name RestrictedInventorySlotUI

var restrict_type: Variant

func init(init_item_stack: ItemStack, init_restrict_type: Variant = Item) -> void:
	super(init_item_stack)
	restrict_type = init_restrict_type

func _handle_left_click() -> void:
	var held_stack: ItemStack = InventoryUIManager.held_stack
	if not held_stack.is_empty() and not is_instance_of(held_stack.item, restrict_type):
		return
	
	super()

func _handle_right_click() -> void:
	var held_stack: ItemStack = InventoryUIManager.held_stack
	if not held_stack.is_empty() and not is_instance_of(held_stack.item, restrict_type):
		return
	
	super()
