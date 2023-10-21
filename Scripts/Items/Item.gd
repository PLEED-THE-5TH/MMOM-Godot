# This is an abstract class.
# To create an item, create a new script that extends Item.
# Override _init() to assign custom values to the variables.

class_name Item

var item_type: String:
	get:
		return item_type
var max_stack_size: int:
	get:
		return max_stack_size
var description: String:
	get:
		return description
var icon_resource: ResourceManager.ManagedResource:
	get:
		return icon_resource

func get_icon() -> Texture2D:
	return icon_resource.get_value()
