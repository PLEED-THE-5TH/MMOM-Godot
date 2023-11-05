extends Control

class_name InventoryManager

static var singleton: InventoryManager:
	get:
		return singleton

func _ready() -> void:
	singleton = self

static func toggle_inventories() -> void:
	singleton.visible = not singleton.visible
	
	if not singleton.visible:
		var player: Player = Player.singleton
		player.inventory.auto_add(player.held_stack)
		if not player.held_stack.is_empty():
			player.held_stack.drop_at(player.position)
	
	# TODO: check for distance to player
