extends AspectRatioContainer

class_name InventoryUI

func init(inventory: Inventory, target_aspect_ratio: float, grid_scale: float) -> void:
	var slot_grid: GridContainer = $"Slot Grid"
	
	InventoryManager.singleton.add_child(self)
	
	name = "Inventory [" + str(inventory.max_stacks) + "]"
	var grid_dimensions: Vector2i = InventoryUI._get_grid_dimensions(target_aspect_ratio, inventory.max_stacks)
	slot_grid.columns = grid_dimensions.x
	ratio = InventoryUI._get_aspect_ratio(grid_dimensions)
	size = Vector2(grid_dimensions) * grid_scale
	
	for index in range(inventory.max_stacks):
		var item_slot: InventorySlot = ResourceManager.item_slot_scene.get_value().instantiate()
		item_slot.init(inventory.stacks[index])
		item_slot.name = "Slot " + str(index)
		slot_grid.add_child(item_slot)

static func _get_aspect_ratio(dimensions: Vector2i):
	return float(dimensions.x) / float(dimensions.y)

static func _get_grid_dimensions(target_aspect_ratio: float, total_slots: int) -> Vector2i:
	var best = {
		"dimensions": Vector2i.ZERO,
		"aspect_ratio_diff": INF
	}
	
	var set_best = func(cols: int, rows: int) -> void:
		var dimensions: Vector2i = Vector2i(cols, rows)
		var dimensions_ratio: float = _get_aspect_ratio(dimensions)
		var aspect_ratio_diff: float = max(target_aspect_ratio, dimensions_ratio) / min(target_aspect_ratio, dimensions_ratio)
		if aspect_ratio_diff < best.aspect_ratio_diff:
			best.dimensions = dimensions
			best.aspect_ratio_diff = aspect_ratio_diff
	
	for cols in range(1, sqrt(total_slots) + 1):
		if total_slots % cols != 0:
			continue
		
		@warning_ignore("integer_division")
		var rows = total_slots / cols
		set_best.call(rows, cols)
		set_best.call(cols, rows)
	
	return best.dimensions