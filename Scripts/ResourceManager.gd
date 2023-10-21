class_name ResourceManager

class ManagedResource:
	var _value: Resource
	var _path: String
	
	func _init(path: String):
		_path = path
	
	func load_value() -> void:
		print("Loading " + _path)
		_value = load(_path)
	
	func unload_value() -> void:
		print("Unloading " + _path)
		_value = null
	
	func get_value(immediate_unload: bool = false) -> Resource:
		if not _value:
			load_value()
		if immediate_unload:
			call_deferred("unload_value")
		return _value

# Scenes
static var held_stack_scene: ManagedResource = ManagedResource.new("res://Scenes/Templates/Inventory/Held Stack.tscn"):
	get:
		return held_stack_scene
static var inventory_scene: ManagedResource = ManagedResource.new("res://Scenes/Templates/Inventory/Inventory.tscn"):
	get:
		return inventory_scene
static var item_slot_scene: ManagedResource = ManagedResource.new("res://Scenes/Templates/Inventory/Inventory Slot.tscn"):
	get:
		return item_slot_scene
static var item_stack_scene: ManagedResource = ManagedResource.new("res://Scenes/Templates/Inventory/Item Stack.tscn"):
	get:
		return item_stack_scene
static var player_inventory_scene: ManagedResource = ManagedResource.new("res://Scenes/Templates/Inventory/Player Inventory.tscn"):
	get:
		return player_inventory_scene

# Icons
static var apple_icon: ManagedResource = ManagedResource.new("res://Assets/Textures/Item Icons/Apple Icon.tres"):
	get:
		return apple_icon
static var book_icon: ManagedResource = ManagedResource.new("res://Assets/Textures/Item Icons/Book Icon.tres"):
	get:
		return book_icon
static var wood_sword_icon: ManagedResource = ManagedResource.new("res://Assets/Textures/Item Icons/Wood Sword.tres"):
	get:
		return wood_sword_icon
