extends Weapon

class_name WoodSword

func _init() -> void:
	item_type = "WoodSword"
	max_stack_size = 1
	description = "A weak sword made of wood."
	icon_resource = ResourceManager.wood_sword_icon
