extends Control

class_name PlayerInventoryUI

static var singleton: PlayerInventoryUI

var slot_grid: InventorySlotGridUI
var item_name_label: Label
var item_description_label: RichTextLabel

func _ready() -> void:
	singleton = self
	
	item_name_label = $"Top/Info Tabs/Item Info/Tab Elements/Item Name"
	item_description_label = $"Top/Info Tabs/Item Info/Tab Elements/Item Description"

func init(inventory: Inventory) -> void:
	inventory.ui.name = "Inventory Slot Grid"
	$"Bottom/Slot Grid View".add_child(inventory.ui)
	$"Bottom/Slot Grid View".init()
	inventory.ui.position.x = 0
	
	var restricted_slot_types: Dictionary = {
		$"Top/Equipment/Armor Slots/Helmet Slot": Helmet,
		$"Top/Equipment/Armor Slots/Chestplate Slot": Chestplate,
		$"Top/Equipment/Armor Slots/Leggings Slot": Leggings,
		$"Top/Equipment/Armor Slots/Boots Slot": Boots,
		$"Top/Equipment/Tool Slots/Mining Tool Slot": MiningTool,
		$"Top/Equipment/Tool Slots/Weapon Slot": Weapon,
		$"Top/Equipment/Tool Slots/Accessory Slots/Accessory 1 Slot": Accessory,
		$"Top/Equipment/Tool Slots/Accessory Slots/Accessory 2 Slot": Accessory
	}
	
	for slot in restricted_slot_types:
		(slot as RestrictedInventorySlotUI).init(ItemStack.new(), restricted_slot_types[slot])
