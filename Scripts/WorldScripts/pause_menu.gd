extends Control

var pausemenu = false

@onready var player = $"../../Player"

func _ready() -> void:
	#exit.button_pressed.connect()
	#button.button_down.connect(_on_button_down)
	pass

func toggle_pausemenu() -> void:
	if pausemenu == false:
		show()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		pausemenu = true
		player.freeze_camera = 1
	else:
		hide()
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		pausemenu = false
		player.freeze_camera = 0

#These buttons are connected through NODES. So i would like to change that
func _on_resume_pressed():
	hide()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	pausemenu = false
	player.freeze_camera = 0

func _on_settings_pressed():
	pass

func _on_exit_pressed():
	get_tree().quit()
