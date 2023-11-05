@tool
extends EditorPlugin

class_name CreateItemPlugin

static var editor_interface: EditorInterface
static var base_control: Control
static var resource_filesystem: EditorFileSystem
static var dock: Control

func _enter_tree() -> void:
	editor_interface = get_editor_interface()
	base_control = editor_interface.get_base_control()
	resource_filesystem = editor_interface.get_resource_filesystem()
	
	dock = load("res://Addons/Create Item/Dock.tscn").instantiate()
	editor_interface.get_editor_main_screen().add_child(dock)
	_load_defaults()
	
	_make_visible(false)

static func _load_defaults() -> void:
	var defaults: ConfigFile = ConfigFile.new()
	defaults.load("res://addons/Create Item/plugin.cfg")
	
	dock.name_input.text = defaults.get_value("defaults", "name")
	dock.parent_input.text = defaults.get_value("defaults", "parent")
	_load_default_parent_options(defaults)
	dock.max_stack_size_input.value = int(defaults.get_value("defaults", "max_stack_size"))
	dock.description_input.text = defaults.get_value("defaults", "description")
	dock.save_path_input.text = defaults.get_value("defaults", "save_path")
	dock.resource_manager_path_input.text = defaults.get_value("defaults", "resource_manager_path")
	dock.icon_path_input.text = defaults.get_value("defaults", "icon_path")

static func _load_default_parent_options(defaults: ConfigFile) -> void:
	var parent_options: OptionButton = dock.parent_input.options
	
	while parent_options.item_count > 0:
		parent_options.remove_item(0)
	
	for option in defaults.get_value("defaults", "parent_options"):
		dock.parent_input.options.add_item(option)
	
	parent_options.select(-1)

func _make_visible(visible) -> void:
	if dock:
		dock.visible = visible

func _exit_tree() -> void:
	if dock:
		dock.queue_free()

func _get_plugin_icon() -> Texture2D:
	return get_editor_interface().get_base_control().get_theme_icon("ScriptCreate", "EditorIcons")

func _get_plugin_name() -> String:
	return "Create Item"
	
func _has_main_screen() -> bool:
	return true
