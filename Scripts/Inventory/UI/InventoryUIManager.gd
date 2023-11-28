extends Control

class_name InventoryUIManager

static var singleton: InventoryUIManager

static var hover_item_stack: ItemStack:
	get:
		return hover_item_stack
	set(new_hover_item_stack):
		hover_item_stack = new_hover_item_stack
		_on_hover_item_stack_changed()

var held_item_stack_ui: ItemStackUI

static var held_stack: ItemStack:
	get:
		return singleton.held_item_stack_ui.item_stack

func _ready() -> void:
	singleton = self
	
	held_item_stack_ui = $"Held Item Stack"

static func show_inventories() -> void:
	if singleton.visible:
		return
	
	singleton.visible = true
	
	update_item_info()

static func hide_inventories() -> void:
	if not singleton.visible:
		return
	
	singleton.visible = false
	
	if not held_stack.is_empty():
		Player.singleton.inventory.auto_add(held_stack)
		if not held_stack.is_empty():
			held_stack.drop()

static func toggle_inventories() -> void:
	hide_inventories() if singleton.visible else show_inventories()

static func _on_hover_item_stack_changed() -> void:
	if not held_stack.is_empty():
		return
	
	update_item_info()

static func update_item_info() -> void:
	if not held_stack.is_empty():
		_set_item_name_and_description_from_stack(held_stack)
		return
	
	if not hover_item_stack or hover_item_stack.is_empty():
		_set_item_name_and_description("", "")
		return
	
	_set_item_name_and_description_from_stack(hover_item_stack)

static func _set_item_name_and_description_from_stack(item_stack: ItemStack) -> void:
	if not item_stack or item_stack.is_empty():
		_set_item_name_and_description("", "")
		return
	
	_set_item_name_and_description(item_stack.item.name, item_stack.item.description)

static func _set_item_name_and_description(item_name: String, item_description: String) -> void:
	PlayerInventoryUI.singleton.item_name_label.text = item_name
	PlayerInventoryUI.singleton.item_description_label.text = item_description
