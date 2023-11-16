extends ItemStackUI

@export var mouse_offset: Vector2 = Vector2(10, 10)

func _ready() -> void:
	init(ItemStack.new())

func _input(event: InputEvent) -> void:
	var mouse_move_event: InputEventMouseMotion = event as InputEventMouseMotion
	if not mouse_move_event:
		return
	
	position = mouse_move_event.position + mouse_offset
