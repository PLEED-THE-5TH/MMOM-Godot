class_name DungeonMeshCell

var terrain: DungeonTerrain
var grid_location: Vector3i

var cell_node: DungeonMeshCellNode

func _init(init_terrain: DungeonTerrain, init_grid_location: Vector3i) -> void:
	terrain = init_terrain
	grid_location = init_grid_location
	
	(
		func():
			_connect_surrounding_cells()
			cell_node = DungeonMeshCellNode.new(get_new_mesh_node(), self)
			cell_node.global_position = Vector3(grid_location) + (Vector3.ONE * 0.5)
	).call_deferred()

func _connect_surrounding_cells() -> void:
	var loop_range: Array = range(0, 2)
	for x in loop_range:
		for y in loop_range:
			for z in loop_range:
				var cell: DungeonCell = terrain.get_cell_at(grid_location + Vector3i(x, y, z))
				if cell:
					cell.contents_updated.connect(update)

func get_mesh_key() -> int:
	var mesh_key: int = 0
	var loop_range: Array = range(0, 2)
	for x in loop_range:
		for y in loop_range:
			for z in loop_range:
				var cell: DungeonCell = terrain.get_cell_at(grid_location + Vector3i(x, y, z))
				var bit: int = 0 if cell.contents == "air" else 1
				var index: int = (x << 2) + (y << 1) + z
				mesh_key += bit << index
	return mesh_key

func get_new_mesh_node() -> Node3D:
	return DungeonMeshLookup.get_mesh_node(get_mesh_key())

func update() -> void:
	cell_node.mesh_node.queue_free()
	var mesh_node: Node3D = get_new_mesh_node()
	cell_node.add_child(mesh_node)
	cell_node.mesh_node = mesh_node
