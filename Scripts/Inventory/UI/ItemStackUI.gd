extends AspectRatioContainer

class_name ItemStackUI

var icon_ui: TextureRect
var stack_size_ui: Label

var item_stack: ItemStack

func init(init_item_stack: ItemStack) -> void:
	icon_ui = $"Icon"
	stack_size_ui = $"Stack Size"
	item_stack = init_item_stack
	item_stack.changed.connect(update)
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func update() -> void:
	icon_ui.texture = null if item_stack.is_empty() else item_stack.item.icon 
	stack_size_ui.text = str(item_stack.size) if (item_stack.size > 0 and item_stack.item.max_stack_size > 1) else ""

func _on_mouse_entered() -> void:
	InventoryUIManager.hover_item_stack_ui = self

func _on_mouse_exited() -> void:
	InventoryUIManager.hover_item_stack_ui = null
