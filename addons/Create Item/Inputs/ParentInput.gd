@tool
extends CIPLineEdit

@onready var options: OptionButton = $"../Parent Options"

func _ready() -> void:
	_icon_name = "Reparent"
	super()
	
	options.item_selected.connect(_on_option_selected)

func _on_option_selected(index: int) -> void:
	text = options.get_item_text(index)
	text_changed.emit(text)
