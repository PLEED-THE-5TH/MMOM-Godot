class_name DungeonCell

signal contents_updated()

var chunk: DungeonChunk
var grid_location: Vector3i

# this can be changed in the future
var contents = "not air":
	get:
		return contents
	set(new_contents):
		contents = new_contents
		contents_updated.emit()

func _init(init_chunk: DungeonChunk, init_grid_location: Vector3i) -> void:
	chunk = init_chunk
	grid_location = init_grid_location
