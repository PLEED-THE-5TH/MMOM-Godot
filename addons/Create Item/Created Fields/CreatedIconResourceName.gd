@tool
extends Label

func _ready() -> void:
	call_deferred("_on_name_input_text_changed", "")

# see Dock/Elements/Fields/Name Input.text_changed signal
func _on_name_input_text_changed(_new_text: String) -> void:
	text = CreateItemPlugin.dock.get_created_icon_resource_name()
