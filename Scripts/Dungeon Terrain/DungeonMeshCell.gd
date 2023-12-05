class_name DungeonMeshCell

var terrain: DungeonTerrain
var grid_location: Vector3i

var surrounding_cells: Array

func _init(init_terrain: DungeonTerrain, init_grid_location: Vector3i) -> void:
	terrain = init_terrain
	grid_location = init_grid_location
	
	_connect_surrounding_cells()
	
	_create_node()

func _connect_surrounding_cells() -> void:
	# TODO
	var loop_range: Array = range(0, 2)
	for x in loop_range:
		for y in loop_range:
			for z in loop_range:
				_connect_cell(x, y, z)

func _connect_cell(x: int, y: int, z: int) -> void:
	terrain.get_cell_from_grid_location(Vector3i(x, y, z)).contents_updated.connect(update)

func _create_node() -> void:
	var _node = DungeonMeshCellNode.new()

func update() -> void:
	pass
