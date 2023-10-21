@tool
extends CIPLineEditWithValidation

class_name CIPLineEditWithFSValidation

func _ready() -> void:
	super()
	CreateItemPlugin.resource_filesystem.filesystem_changed.connect(_do_ui_validation)
