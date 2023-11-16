class_name Inventory

var inventory_scene: PackedScene = preload("res://Scenes/Templates/Inventory/Inventory Slot Grid.tscn")

var stacks: Array[ItemStack] = []
var owner: Node3D
var ui: InventorySlotGridUI

func _init(num_stacks: int, num_columns: int, inventory_owner: Node3D) -> void:
	owner = inventory_owner
	
	for index in range(num_stacks):
		stacks.append(ItemStack.new())
	
	ui = inventory_scene.instantiate()
	ui.init(self, num_columns)

func auto_add(new_item_stack: ItemStack) -> void:
	for item_stack in stacks:
		item_stack.combine(new_item_stack, true)
		if new_item_stack.is_empty():
			return
