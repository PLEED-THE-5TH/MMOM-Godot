extends Node3D

class_name ItemStackDrop

var item_stack: ItemStack:
	get:
		return item_stack

func _init(init_item_stack: ItemStack, init_position: Vector3) -> void:
	item_stack = init_item_stack
	
	position = init_position
	
	# TODO: add to the scene
