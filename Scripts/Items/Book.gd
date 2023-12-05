extends Item

class_name Book

func _init() -> void:
	name = "Book"
	max_stack_size = 3
	description = "A mysterious book written in a foreign language."
	icon = preload("res://Textures/Item Icons/Book.tres")
