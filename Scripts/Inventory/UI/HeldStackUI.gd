extends ItemStackUI

@export var item_stack_ui_size: Vector2 = Vector2(40, 40)
@export var mouse_offset: Vector2 = Vector2(10, 10)

func _ready() -> void:
	init(ItemStack.new())
	size = item_stack_ui_size

func _input(event: InputEvent) -> void:
	var mouse_move_event: InputEventMouseMotion = event as InputEventMouseMotion
	if not mouse_move_event:
		return
	
	position = mouse_move_event.position + mouse_offset
