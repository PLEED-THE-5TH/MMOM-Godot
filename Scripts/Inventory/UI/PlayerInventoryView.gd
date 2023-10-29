extends Control

var scroll_sensitivity: float = 5

@onready var scroll_bar: VScrollBar = $"../Scroll Bar":
	get:
		return scroll_bar
@onready var aspect_ratio_container: AspectRatioContainer = $"Aspect Ratio Container":
	get:
		return aspect_ratio_container
@onready var slot_grid: GridContainer = $"Aspect Ratio Container/Slot Grid":
	get:
		return slot_grid

func _ready() -> void:
	scroll_bar.value_changed.connect(_handle_scroll)
	
	# if anything causes the aspect ratio container to change size/location,
	# reset it to where it should be
	aspect_ratio_container.item_rect_changed.connect(func(): call_deferred("_correct_container_position"))

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
	_correct_container_position()
	
func _correct_container_position() -> void:
	aspect_ratio_container.position.y = (aspect_ratio_container.size.y - slot_grid.size.y - scroll_bar.page) * scroll_bar.value / scroll_bar.max_value
