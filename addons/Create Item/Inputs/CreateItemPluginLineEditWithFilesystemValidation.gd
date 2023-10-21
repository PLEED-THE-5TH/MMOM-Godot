@tool
extends CIPLineEdit

class_name CIPLineEditWithValidation

var _validation_method: String

func _ready() -> void:
	super()
	call_deferred("_do_ui_validation")
	text_changed.connect(func(_new_text: String): _do_ui_validation())

func _do_ui_validation() -> void:
	CreateItemPlugin.dock.update_ui_validation(self, _validation_method)
