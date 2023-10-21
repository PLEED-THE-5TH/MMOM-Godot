extends Item

class_name Book

func _init() -> void:
	item_type = "Book"
	max_stack_size = 3
	description = "A mysterious book written in a foreign language."
	icon_resource = ResourceManager.book_icon
