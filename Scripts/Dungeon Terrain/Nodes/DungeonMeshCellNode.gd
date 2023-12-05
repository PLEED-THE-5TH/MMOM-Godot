extends Node3D

var mesh: MeshInstance3D

func _ready() -> void:
	mesh = MeshInstance3D.new()
	add_child(mesh)
