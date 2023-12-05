extends Node3D

var terrain: DungeonTerrain

func _ready() -> void:
	terrain = DungeonTerrain.new(3, 3, 3)
	
