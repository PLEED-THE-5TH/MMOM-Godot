extends Control

@export var scroll_sensitivity: float = 5

@onready var scroll_bar: VScrollBar = $"../Scroll Bar"
@onready var slot_grid: InventoryUI = $"Slot Grid"

func _ready() -> void:
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
	var rows: int = slot_grid.get_child_count() / slot_grid.columns
	var single_slot_size: float = size.x / slot_grid.columns
	slot_grid.size = Vector2(slot_grid.columns, rows) * single_slot_size
	_handle_scroll(0)
