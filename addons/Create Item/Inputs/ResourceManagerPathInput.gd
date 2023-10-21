@tool
extends CIPLineEditWithFSValidation

func _ready() -> void:
	_icon_name = "Tree"
	_validation_method = "validate_resource_manager_path"
	super()
