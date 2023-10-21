@tool
extends LineEdit

class_name CIPLineEdit

var _icon_name: String

func _ready() -> void:
	right_icon = CreateItemPlugin.base_control.get_theme_icon(_icon_name, "EditorIcons")
