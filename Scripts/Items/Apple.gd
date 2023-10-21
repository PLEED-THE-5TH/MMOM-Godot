extends Item

class_name Apple

func _init() -> void:
	item_type = "Apple"
	max_stack_size = 5
	description = "A delicious apple."
	icon_resource = ResourceManager.apple_icon
