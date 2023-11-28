extends Control

class_name PlayerInventorySlotGridViewUI

@export var scroll_sensitivity: float = 5

var scroll_bar: VScrollBar
var slot_grid: InventorySlotGridUI

func init() -> void:
	scroll_bar = $"../Scroll Bar"
	slot_grid = $"Inventory Slot Grid"
	scroll_bar.value_changed.connect(_handle_scroll)
	resized.connect(_resize_slot_grid)

func _gui_input(event: InputEvent) -> void:
	var mouse_button_event: InputEventMouseButton = event as InputEventMouseButton
	
	if not mouse_button_event or not mouse_button_event.pressed:
		return
	
	match mouse_button_event.button_index:
		MOUSE_BUTTON_WHEEL_DOWN:
			scroll_bar.value += scroll_sensitivity
		MOUSE_BUTTON_WHEEL_UP:
			scroll_bar.value -= scroll_sensitivity

func _handle_scroll(_new_value: float) -> void:
	var scroll_progress: float = scroll_bar.value / (scroll_bar.max_value - scroll_bar.page)
	var full_scroll_offset: float = size.y - slot_grid.size.y
	slot_grid.position.y = full_scroll_offset * scroll_progress

func _resize_slot_grid() -> void:
	@warning_ignore("integer_division")
	var rows: int = slot_grid.inventory.stacks.size() / slot_grid.columns
	var single_slot_size: float = size.x / slot_grid.columns
	slot_grid.set_deferred("size", Vector2(slot_grid.columns, rows) * single_slot_size)
	slot_grid.set_deferred("position", Vector2.ZERO)
	_handle_scroll(0)
