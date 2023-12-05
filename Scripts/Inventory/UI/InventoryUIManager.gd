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
var top_right: Control
var bottom_right: Control
var bottom_left: Control

static var held_stack: ItemStack:
	get:
		return singleton.held_item_stack_ui.item_stack

func _ready() -> void:
	singleton = self
	
	held_item_stack_ui = $"Held Item Stack"
	top_right = $"Quadrants/Top Right"
	bottom_right = $"Quadrants/Bottom Right"
	bottom_left = $"Quadrants/Bottom Left"

static func show_inventories() -> void:
	if singleton.visible:
		return
	
	singleton.visible = true
	
	update_item_info()

static func hide_inventories() -> void:
	if not singleton.visible:
		return
	
	singleton.visible = false
	
	hover_item_stack = null
	set_bottom_right(null)
	
	if not held_stack.is_empty():
		Player.singleton.inventory.auto_add(held_stack)
		if not held_stack.is_empty():
			held_stack.drop()

static func toggle_inventories() -> void:
	hide_inventories() if singleton.visible else show_inventories()

static func set_top_right(control: Control) -> void:
	_set_quadrant(singleton.top_right, control)

static func set_bottom_right(control: Control) -> void:
	_set_quadrant(singleton.bottom_right, control)

static func set_bottom_left(control: Control) -> void:
	_set_quadrant(singleton.bottom_left, control)

static func _set_quadrant(quadrant: Control, child: Control) -> void:
	if quadrant.get_child_count() > 0:
		quadrant.remove_child(quadrant.get_child(0))
	
	if child:
		quadrant.add_child(child)

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
