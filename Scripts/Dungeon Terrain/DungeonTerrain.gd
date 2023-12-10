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
				row.append(DungeonMeshCell.new(self, Vector3i(x, y, z)))
			slice.append(row)
		meshes.append(slice)

func _is_valid_coord(coord: int, limit: int) -> bool:
	return 0 <= coord and coord < limit

func get_total_cells() -> Vector3i:
	return Vector3i(
		chunks.size() * DungeonChunk.size.x,
		chunks[0].size() * DungeonChunk.size.y,
		chunks[0][0].size() * DungeonChunk.size.z,
	)

func is_valid_x_coord(x_coord: int) -> bool:
	return _is_valid_coord(x_coord, chunks.size() * DungeonChunk.size.x)
func is_valid_y_coord(y_coord: int) -> bool:
	return _is_valid_coord(y_coord, chunks[0].size() * DungeonChunk.size.y)
func is_valid_z_coord(z_coord: int) -> bool:
	return _is_valid_coord(z_coord, chunks[0][0].size() * DungeonChunk.size.z)

func is_valid_grid_location(grid_location: Vector3i) -> bool:
	return (
		is_valid_x_coord(grid_location.x) and
		is_valid_y_coord(grid_location.y) and
		is_valid_z_coord(grid_location.z)
	)

func get_chunk_at(grid_location: Vector3i) -> DungeonChunk:
	if not is_valid_grid_location(grid_location):
		return null
	
	@warning_ignore("integer_division")
	return Helper.get_3d_array_value(grid_location / DungeonChunk.size, chunks)

func get_cell_at(grid_location: Vector3i) -> DungeonCell:
	var chunk = get_chunk_at(grid_location)
	if not chunk:
		return null
	
	return Helper.get_3d_array_value(grid_location % DungeonChunk.size, chunk.cells)
