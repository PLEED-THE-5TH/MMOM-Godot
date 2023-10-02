extends Node3D

@onready var camera_mount = $"."

func _process(_delta):
	camera_mount.rotation.x = clamp(camera_mount.rotation.x, -1.4, 1.4)
