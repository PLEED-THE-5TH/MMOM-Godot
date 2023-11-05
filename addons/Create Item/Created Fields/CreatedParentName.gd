@tool
extends Label

func _ready() -> void:
	call_deferred("_on_parent_input_text_changed", "")

# see Dock/Elements/Fields/Parent Input.text_changed signal
func _on_parent_input_text_changed(_new_text: String) -> void:
	var dock: CIPDock = CreateItemPlugin.dock
	text = dock.get_created_parent_name()
	
	var validity: CIPDock.Validity = dock.validate_parent()
	if not validity.valid:
		tooltip_text = validity.message
		add_theme_color_override("font_color", Color.TOMATO)
		return
	
	if not _is_default_parent_option(text):
		tooltip_text = "\"" + text + "\" is not a default parent option."
		add_theme_color_override("font_color", Color.YELLOW)
		return
	
	tooltip_text = ""
	remove_theme_color_override("font_color")

func _is_default_parent_option(created_parent_name: String) -> bool:
	var parent_options: OptionButton = CreateItemPlugin.dock.parent_input.options
	for i in range(parent_options.item_count):
		if created_parent_name == parent_options.get_item_text(i).to_pascal_case():
			return true
	return false
