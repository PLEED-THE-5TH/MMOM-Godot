extends Control

class_name InventoryUIManager

static var singleton: InventoryUIManager

static var hover_item_stack_ui: ItemStackUI:
	get:
		return hover_item_stack_ui
	set(new_hover_item_stack_ui):
		hover_item_stack_ui = new_hover_item_stack_ui
		_on_hover_item_stack_ui_changed()

@onready var held_item_stack_ui: ItemStackUI = $"Held Item Stack"
@onready var player_inventory_slot_grid: InventorySlotGridUI = $"Quadrants/Top Left/Player Inventory/Bottom/Slot Grid View/Inventory Slot Grid"

static var held_stack: ItemStack:
	get:
		return singleton.held_item_stack_ui.item_stack

func _ready() -> void:
	singleton = self

static func toggle_inventories() -> void:
	# TODO
	pass

static func _on_hover_item_stack_ui_changed() -> void:
	# TODO
	pass
