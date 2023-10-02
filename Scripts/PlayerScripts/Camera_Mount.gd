extends Node3D

func _process(_delta):
	rotation.x = clamp(rotation.x, -1.4, 1.4)
