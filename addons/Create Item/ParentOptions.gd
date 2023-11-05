@tool
extends OptionButton

func _ready() -> void:
	item_selected.connect(_on_item_selected)

func _on_item_selected(index: int) -> void:
	select(-1)
