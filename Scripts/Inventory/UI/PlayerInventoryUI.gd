extends Control

class_name PlayerInventoryUI

static var singleton: PlayerInventoryUI

var slot_grid: InventorySlotGridUI
var item_name_label: Label
var item_description_label: RichTextLabel

func _ready() -> void:
	singleton = self
	
	var item_info_elements: Control = $"Sections/Top/Info Tabs/Item Info/Tab Elements"
	item_name_label = item_info_elements.get_node("Item Name")
	item_description_label = item_info_elements.get_node("Item Description")

func init(inventory: Inventory) -> void:
	inventory.ui.name = "Inventory Slot Grid"
	var slot_grid_view: PlayerInventorySlotGridViewUI = $"Sections/Bottom/Slot Grid View"
	slot_grid_view.add_child(inventory.ui)
	slot_grid_view.init()
	inventory.ui.position.x = 0
	
	var equipment: Control = $"Sections/Top/Equipment"
	var armor_slots: Control = equipment.get_node("Armor Slots")
	var tool_slots: Control = equipment.get_node("Tool Slots")
	var accessory_slots: Control = tool_slots.get_node("Accessory Slots")
	var restricted_slot_types: Dictionary = {
		armor_slots.get_node("Helmet Slot"): Helmet,
		armor_slots.get_node("Chestplate Slot"): Chestplate,
		armor_slots.get_node("Leggings Slot"): Leggings,
		armor_slots.get_node("Boots Slot"): Boots,
		tool_slots.get_node("Mining Tool Slot"): MiningTool,
		tool_slots.get_node("Weapon Slot"): Weapon,
		accessory_slots.get_node("Accessory 1 Slot"): Accessory,
		accessory_slots.get_node("Accessory 2 Slot"): Accessory
	}
	
	for slot in restricted_slot_types:
		slot.init(ItemStack.new(), restricted_slot_types[slot])
