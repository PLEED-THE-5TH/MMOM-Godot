extends Control

class_name PlayerInventoryUI

@onready var slot_grid: InventorySlotGridUI = $"Bottom/Inventory View/Inventory Slot Grid"

func init(inventory: Inventory, columns: int) -> void:
	slot_grid.init(inventory, columns)
	
	var restricted_slot_types: Dictionary = {
		$"Top/Equipment/Armor/Helmet": Helmet,
		$"Top/Equipment/Armor/Chestplate": Chestplate,
		$"Top/Equipment/Armor/Leggings": Leggings,
		$"Top/Equipment/Armor/Boots": Boots,
		$"Top/Equipment/Tools/Mining Tool": MiningTool,
		$"Top/Equipment/Tools/Weapon": Weapon,
		$"Top/Equipment/Tools/Accessories/Accessory 1": Accessory,
		$"Top/Equipment/Tools/Accessories/Accessory 2": Accessory
	}
	
	for slot in restricted_slot_types:
		slot.init(ItemStack.new(), restricted_slot_types[slot])
