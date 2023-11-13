class_name Inventory

var inventory_scene: PackedScene = preload("res://Scenes/Templates/Inventory/Inventory.tscn")

var max_stacks: int
var stacks: Array[ItemStack] = []

func _init(init_max_stacks: int, ui_aspect_ratio: float, ui_scale: float) -> void:
	max_stacks = init_max_stacks
	
	for index in range(max_stacks):
		stacks.append(ItemStack.new())
	
	inventory_scene.instantiate().init(self, ui_aspect_ratio, ui_scale)

func auto_add(new_item_stack: ItemStack) -> void:
	for item_stack in stacks:
		item_stack.combine(new_item_stack, true)
		if new_item_stack.is_empty():
			return
