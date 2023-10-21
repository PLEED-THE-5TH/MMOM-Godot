@tool
extends Label

func _ready() -> void:
	call_deferred("_update_text")
	CreateItemPlugin.resource_filesystem.filesystem_changed.connect(_do_ui_validation)

func _do_ui_validation() -> void:
	CreateItemPlugin.dock.update_ui_validation(self, "validate_new_file_path")

func _update_text() -> void:
	text = CreateItemPlugin.dock.get_created_new_file_path()
	
	_do_ui_validation()

# see Dock/Elements/Fields/Name Input.text_changed signal
func _on_name_input_text_changed(_new_text: String) -> void:
	_update_text()
	
# see Dock/Elements/Fields/Save Path Input.text_changed signal
func _on_save_path_input_text_changed(_new_text: String) -> void:
	_update_text()
