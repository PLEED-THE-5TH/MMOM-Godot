extends Node3D

class_name DungeonMeshCellNode

var mesh_node: Node3D

func _init(init_mesh_node: Node3D, mesh_cell: DungeonMeshCell) -> void:
	name = "Mesh Cell (" + str(mesh_cell.grid_location.x) + ", " + str(mesh_cell.grid_location.y) + ", " + str(mesh_cell.grid_location.z) + ")"
	
	mesh_node = init_mesh_node
	add_child(mesh_node)
	
	var chunk: DungeonChunk = mesh_cell.terrain.get_chunk_at(mesh_cell.grid_location)
	chunk.chunk_node.add_child(self)
