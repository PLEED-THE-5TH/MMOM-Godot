class_name DungeonTerrain

var chunks: Array
var meshes: Array

func _init(x_chunks: int, y_chunks: int, z_chunks: int) -> void:
	_init_chunks(x_chunks, y_chunks, z_chunks)
	_init_meshes(x_chunks, y_chunks, z_chunks)

func _init_chunks(x_chunks: int, y_chunks: int, z_chunks: int) -> void:
	for x in range(x_chunks):
		var slice: Array = []
		for y in range(y_chunks):
			var row: Array[DungeonChunk] = []
			for z in range(z_chunks):
				row.append(DungeonChunk.new(self, Vector3i(x, y, z)))
			slice.append(row)
		chunks.append(slice)

func _init_meshes(x_chunks: int, y_chunks: int, z_chunks: int) -> void:
	var width: int = (x_chunks * DungeonChunk.size.x) - 1
	var height: int = (y_chunks * DungeonChunk.size.y) - 1
	var depth: int = (z_chunks * DungeonChunk.size.z) - 1
	for x in range(width):
		var slice: Array = []
		for y in range(height):
			var row: Array[DungeonMeshCell] = []
			for z in range(depth):
				var mesh_node = DungeonMeshCell.new(self, Vector3i(x, y, z))
				mesh_node.connect_surrounding_nodes()
				row.append(mesh_node)
			slice.append(row)
		meshes.append(slice)

func get_chunk_from_grid_location(grid_location: Vector3i) -> DungeonChunk:
	@warning_ignore("integer_division")
	return chunks[
		grid_location.x / DungeonChunk.size.x
	][
		grid_location.y / DungeonChunk.size.y
	][
		grid_location.z / DungeonChunk.size.z
	]

func get_node_from_grid_location(grid_location: Vector3i) -> DungeonNode:
	return get_chunk_from_grid_location(grid_location).nodes[
		grid_location.x % DungeonChunk.size.x
	][
		grid_location.y % DungeonChunk.size.y
	][
		grid_location.z % DungeonChunk.size.z
	]
