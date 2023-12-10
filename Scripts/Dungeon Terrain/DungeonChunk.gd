class_name DungeonChunk

static var size: Vector3i = Vector3i(16, 16, 16)

var chunk_node: Node3D

var terrain: DungeonTerrain
var grid_location: Vector3i

var cells: Array

func _init(init_terrain: DungeonTerrain, init_grid_location: Vector3i) -> void:
	terrain = init_terrain
	grid_location = init_grid_location
	
	chunk_node = Node3D.new()
	chunk_node.position = grid_location + size
	chunk_node.name = "Chunk (" + str(grid_location.x) + ", " + str(grid_location.y) + ", " + str(grid_location.z) + ")"
	DungeonTerrainManager.singleton.add_child(chunk_node)
	
	for x in range(size.x):
		var slice: Array = []
		for y in range(size.y):
			var row: Array[DungeonCell] = []
			for z in range(size.z):
				row.append(DungeonCell.new(self, Vector3i(x, y, z)))
			slice.append(row)
		cells.append(slice)
