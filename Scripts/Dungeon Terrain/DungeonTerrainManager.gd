extends Node3D

class_name DungeonTerrainManager

static var singleton: DungeonTerrainManager

var terrain: DungeonTerrain

func _ready() -> void:
	singleton = self
	
	terrain = DungeonTerrain.new(5, 3, 5)
	
	_generate_terrain()

func _generate_terrain() -> void:
	var noise: FastNoiseLite = FastNoiseLite.new()
	noise.noise_type = FastNoiseLite.TYPE_PERLIN
	
	var total_cells: Vector3i = terrain.get_total_cells()
	for x in range(1, total_cells.x - 1):
		for y in range(1, total_cells.y - 1):
			for z in range(1, total_cells.z - 1):
				var noise_value: float = noise.get_noise_3d(x * 3, y * 4, z * 3)
				if noise_value < 0:
					terrain.get_cell_at(Vector3i(x, y, z)).contents = "air"
