extends GridContainer

class_name InventorySlotGridUI

var inventory_slot_scene: PackedScene = preload("res://Scenes/Templates/Inventory/Inventory Slot.tscn")

var inventory: Inventory

func init(init_inventory: Inventory, num_columns: int) -> void:
	inventory = init_inventory
	columns = num_columns
	
	for index in range(inventory.stacks.size()):
		var slot: InventorySlotUI = inventory_slot_scene.instantiate()
		for child in slot.get_children():
			print(child)
		add_child(slot)
		slot.init(inventory.stacks[index])
		slot.name = "Slot " + str(index + 1)
