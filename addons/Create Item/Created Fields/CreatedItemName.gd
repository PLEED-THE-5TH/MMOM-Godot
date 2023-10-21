@tool
extends Label

func _ready() -> void:
	call_deferred("_on_name_input_text_changed", "")

# see Dock/Elements/Fields/Parent Input.text_changed signal
func _on_name_input_text_changed(_new_text: String) -> void:
	var dock: CIPDock = CreateItemPlugin.dock
	text = dock.get_created_item_name()
	dock.update_ui_validation(self, "validate_name")
