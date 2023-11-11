extends Inventory

class_name PlayerInventory

var player_inventory_scene: PackedScene = preload("res://Scenes/Templates/Inventory/Player Inventory.tscn")

var ui: PlayerInventoryUI:
	get:
		return ui

func _init(init_max_stacks: int, ui_columns: int) -> void:
	max_stacks = init_max_stacks
	
	for index in range(max_stacks):
		stacks.append(ItemStack.new())
	
	ui = player_inventory_scene.instantiate()
	ui.init(self, ui_columns)
