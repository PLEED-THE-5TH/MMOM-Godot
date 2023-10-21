@tool
extends CIPLineEditWithFSValidation

func _ready() -> void:
	_icon_name = "Save"
	_validation_method = "validate_save_path"
	super()
