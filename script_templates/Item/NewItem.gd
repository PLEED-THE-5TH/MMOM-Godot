extends Item

class_name NewItem

func _init() -> void:
	name = "New Item"
	max_stack_size = 1
	description = "A brand new item."
	# Change `null` to `load("res://path/to/icon/texture.png")`.
	icon = null
