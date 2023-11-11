extends Weapon

class_name WoodSword

func _init() -> void:
	name = "Wood Sword"
	max_stack_size = 1
	description = "A weak sword made of wood."
	icon = preload("res://Textures/Item Icons/Wood Sword.tres")
