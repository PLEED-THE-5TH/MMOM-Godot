extends Inventory

class_name PlayerInventory

func _init(init_max_stacks: int, ui_columns: int) -> void:
	max_stacks = init_max_stacks
	
	for index in range(max_stacks):
		stacks.append(ItemStack.new())
	
	ResourceManager.player_inventory_scene.get_value(true).instantiate().init(self, ui_columns) 
