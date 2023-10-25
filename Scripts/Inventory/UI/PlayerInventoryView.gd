extends Control

var scroll_sensitivity: float = 5

@onready var scroll_bar: VScrollBar = $"../Scroll Bar":
	get:
		return scroll_bar

func _ready() -> void:
	scroll_bar.value_changed.connect(_handle_scroll)
	visibility_changed.connect(_on_visibility_changed)

func _gui_input(event: InputEvent) -> void:
	var mouse_button_event: InputEventMouseButton = event as InputEventMouseButton
	
	if not mouse_button_event or not mouse_button_event.pressed:
		return
	
	match mouse_button_event.button_index:
		MOUSE_BUTTON_WHEEL_DOWN:
			scroll_bar.value += scroll_sensitivity
		MOUSE_BUTTON_WHEEL_UP:
			scroll_bar.value -= scroll_sensitivity

func _on_visibility_changed() -> void:
	if not is_visible_in_tree():
		return
	
	call_deferred("_correct_container_posiiton")

func _handle_scroll(_new_value: float) -> void:
	_correct_container_posiiton()
	
func _correct_container_posiiton() -> void:
	var aspect_ratio_container: AspectRatioContainer = $"Aspect Ratio Container"
	var slot_grid: GridContainer = $"Aspect Ratio Container/Slot Grid"
	
	aspect_ratio_container.position.y = (aspect_ratio_container.size.y - slot_grid.size.y - scroll_bar.page) * scroll_bar.value / scroll_bar.max_value
