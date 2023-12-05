class_name DungeonCell

var chunk: DungeonChunk
var grid_location: Vector3i

# this can be changed in the future
var contents = "air"

var surrounding_mesh_nodes: Array[DungeonMeshCell]

func _init(init_chunk: DungeonChunk, init_grid_location: Vector3i) -> void:
	chunk = init_chunk
	grid_location = init_grid_location

func update_contents(new_contents) -> void:
	contents = new_contents
	_update_surrounding_meshes()

func _update_surrounding_meshes() -> void:
	for mesh_node in surrounding_mesh_nodes:
		mesh_node.update()
