@tool
extends CIPLineEditWithFSValidation

func _ready() -> void:
	_icon_name = "ImageTexture"
	_validation_method = "validate_icon_path"
	super()
