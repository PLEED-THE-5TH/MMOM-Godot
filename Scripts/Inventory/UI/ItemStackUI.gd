extends AspectRatioContainer

class_name ItemStackUI

var item_stack: ItemStack:
	get:
		return item_stack
var icon: TextureRect:
	get:
		return icon
var stack_size: Label:
	get:
		return stack_size

func init(init_item_stack: ItemStack) -> void:
	icon = $"Icon"
	stack_size = $"Size"
	
	item_stack = init_item_stack
	
	self.visibility_changed.connect(update)
	item_stack.changed.connect(update)

func update() -> void:
	if not is_visible_in_tree():
		return
	
	icon.texture = null if item_stack.is_empty() else item_stack.item.icon 
	stack_size.text = str(item_stack.size) if (item_stack.size > 0 and item_stack.item.max_stack_size > 1) else ""
