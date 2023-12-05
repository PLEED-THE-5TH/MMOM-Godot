class_name DungeonMeshCell

var terrain: DungeonTerrain
var grid_location: Vector3i

var surrounding_nodes: Array

func _init(init_terrain: DungeonTerrain, init_grid_location: Vector3i) -> void:
	terrain = init_terrain
	grid_location = init_grid_location

func connect_surrounding_nodes() -> void:
	var loop_range: Array = range(0, 2)
	for x in loop_range:
		for y in loop_range:
			for z in loop_range:
				_connect_node(x, y, z)

func _connect_node(x: int, y: int, z: int) -> void:
	var node: DungeonNode = terrain.get_node_from_grid_location(Vector3i(x, y, z))
	surrounding_nodes.append(node)
	node.surrounding_mesh_nodes.append(self)

func update() -> void:
	pass
