extends GridContainer

class_name InventoryUI

var inventory_slot_scene: PackedScene = preload("res://Scenes/Templates/Inventory/Inventory Slot.tscn")

func init(inventory: Inventory, init_columns: int) -> void:
	if not get_parent():
		InventoryManager.singleton.add_child(self)
	
	name = "Inventory [" + str(inventory.max_stacks) + "]"
	columns = init_columns
	
	for index in range(inventory.max_stacks):
		var inventory_slot: InventorySlot = inventory_slot_scene.instantiate()
		inventory_slot.init(inventory.stacks[index])
		inventory_slot.name = "Slot " + str(index)
		add_child(inventory_slot)

