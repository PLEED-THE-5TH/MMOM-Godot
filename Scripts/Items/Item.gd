# This is an abstract class.
# To create an item, create a new script that extends Item.
# Override _init() to assign custom values to the variables.

class_name Item

var name: String:
	get:
		return name
var max_stack_size: int:
	get:
		return max_stack_size
var description: String:
	get:
		return description
var icon: Texture2D:
	get:
		return icon
