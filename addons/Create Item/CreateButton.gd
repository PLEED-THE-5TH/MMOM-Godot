@tool
extends Button

func _ready() -> void:
	icon = CreateItemPlugin.base_control.get_theme_icon("ScriptCreate", "EditorIcons")

func _pressed():
	if not _validate_all():
		return
	
	var dock: CIPDock = CreateItemPlugin.dock
	
	var icon_res_name = dock.get_created_icon_resource_name()
	
	_append_lines_to_script(dock.resource_manager_path_input.text, [
		"static var " + icon_res_name + ": ManagedResource = ManagedResource.new(\"" + dock.icon_path_input.text + "\"):",
		"	get:",
		"		return " + icon_res_name
	])
	
	var item_name: String = dock.get_created_item_name()
	var new_file_path: String = dock.get_created_save_path()
	_append_lines_to_script(new_file_path, [
		"extends " + dock.get_created_parent_name(),
		"",
		"class_name " + item_name,
		"",
		"func _init() -> void:",
		"	item_type = \"" + item_name + "\"",
		"	max_stack_size = " + str(dock.max_stack_size_input.value),
		"	description = \"" + dock.description_input.text + "\"",
		"	icon_resource = ResourceManager." + icon_res_name
	])
	print("Created " + item_name + " at " + new_file_path)
	
	CreateItemPlugin._load_defaults()

func _validate_all() -> bool:
	for validation_method in [
		"validate_name",
		"validate_parent",
		"validate_save_path",
		"validate_resource_manager_path",
		"validate_icon_path",
		"validate_new_file_path"
	]:
		var validity: CIPDock.Validity = CreateItemPlugin.dock.call(validation_method)
		if not validity.valid:
			push_error(validity.message)
			return false
	return true

func _append_lines_to_script(path: String, lines: Array[String]) -> void:
	var file: FileAccess
	if FileAccess.file_exists(path):
		file = FileAccess.open(path, FileAccess.READ_WRITE)
		file.seek_end()
	else:
		file = FileAccess.open(path, FileAccess.WRITE)
	file.store_string("\n".join(lines) + "\n")
