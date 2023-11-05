@tool
extends Control

class_name CIPDock

@onready var name_input: LineEdit = $"Elements/Fields/Name Input"
@onready var parent_input: LineEdit = $"Elements/Fields/Parent/Parent Input"
@onready var max_stack_size_input: SpinBox = $"Elements/Fields/Max Stack Size Input"
@onready var description_input: TextEdit = $"Elements/Fields/Description Input"
@onready var save_path_input: LineEdit = $"Elements/Fields/Save Path Input"
@onready var resource_manager_path_input: LineEdit = $"Elements/Fields/Resource Manager Path Input"
@onready var icon_path_input: LineEdit = $"Elements/Fields/Icon Path Input"

func get_created_item_name() -> String:
	return name_input.text.to_pascal_case()

func get_created_parent_name() -> String:
	return parent_input.text.to_pascal_case()

func get_created_new_file_path() -> String:
	return save_path_input.text.path_join(get_created_item_name() + ".gd")

func get_created_icon_resource_name() -> String:
	return get_created_item_name().to_snake_case() + "_icon"

class Validity:
	var valid: bool = true
	var message: String
	
	func _init(init_message: String = "") -> void:
		valid = init_message.is_empty()
		message = init_message

func validate_name() -> Validity:
	var item_name: String = get_created_item_name()
	
	if not item_name.is_valid_identifier():
		return Validity.new("Name \"" + item_name + "\" is not a valid identifier")
	
	return Validity.new()

func validate_parent() -> Validity:
	var parent: String = get_created_parent_name()
	
	if not parent.is_valid_identifier():
		return Validity.new("Parent \"" + parent + "\" is not a valid identifier")
	
	return Validity.new()

func validate_path(path: String) -> Validity:
	if not path.begins_with("res://"):
		return Validity.new("Path \"" + path + "\" must begin with \"res://\"")
	
	return Validity.new()

func validate_save_path() -> Validity:
	var save_path: String = save_path_input.text
	
	var path_validity: Validity = validate_path(save_path)
	if not path_validity.valid:
		return path_validity
	
	if not DirAccess.dir_exists_absolute(save_path):
		return Validity.new("Directory \"" + save_path + "\" does not exist")
	
	return Validity.new()

func validate_resource_manager_path() -> Validity:
	var resource_manager_path: String = resource_manager_path_input.text
	
	var path_validity: Validity = validate_path(resource_manager_path)
	if not path_validity.valid:
		return path_validity
		
	if not FileAccess.file_exists(resource_manager_path):
		return Validity.new("File \"" + resource_manager_path + "\" does not exist")
	
	return Validity.new()

func validate_icon_path() -> Validity:
	var icon_path: String = icon_path_input.text
	
	var path_validity: Validity = validate_path(icon_path)
	if not path_validity.valid:
		return path_validity
		
	if not FileAccess.file_exists(icon_path):
		return Validity.new("File \"" + icon_path + "\" does not exist")
	
	return Validity.new()

func validate_new_file_path() -> Validity:
	var new_file_path: String = get_created_new_file_path()
	
	if FileAccess.file_exists(new_file_path):
		return Validity.new("File \"" + new_file_path + "\" already exists")
	
	return Validity.new()

func update_ui_validation(control: Control, validation_method: String) -> void:
	var validity: CIPDock.Validity = call(validation_method)
	if not validity.valid:
		control.tooltip_text = validity.message
		control.add_theme_color_override("font_color", Color.TOMATO)
		return
	
	control.tooltip_text = ""
	control.remove_theme_color_override("font_color")
