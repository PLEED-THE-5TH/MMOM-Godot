extends ItemStackUI

var mouse_offset: Vector2

func init(init_item_stack: ItemStack, init_mouse_offset: Vector2 = Vector2(10, 10)) -> void:
	super(init_item_stack)
	mouse_offset = init_mouse_offset
	
	InventoryManager.singleton.add_child(self)

func _input(event: InputEvent) -> void:
	if not is_visible_in_tree():
		return
	
	var mouse_move_event: InputEventMouseMotion = event as InputEventMouseMotion
	if mouse_move_event:
		position = mouse_move_event.position + mouse_offset
