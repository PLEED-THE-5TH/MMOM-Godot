extends Node3D

class_name DungeonMeshCellNode

var mesh: MeshInstance3D

func _ready() -> void:
	mesh = MeshInstance3D.new()
	add_child(mesh)
