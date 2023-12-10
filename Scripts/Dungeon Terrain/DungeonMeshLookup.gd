class_name DungeonMeshLookup

static var lookup: Dictionary = _get_lookup_data()

static var variants: Array[PackedScene] = [
	load("res://Blender/MarchingCubes/EmptyCubeFrame.blend"),
	load("res://Blender/MarchingCubes/1.blend"),
	load("res://Blender/MarchingCubes/2.blend"),
	load("res://Blender/MarchingCubes/3.blend"),
	load("res://Blender/MarchingCubes/4.blend"),
	load("res://Blender/MarchingCubes/5.blend"),
	load("res://Blender/MarchingCubes/6.blend"),
	load("res://Blender/MarchingCubes/7.blend"),
	load("res://Blender/MarchingCubes/8.blend"),
	load("res://Blender/MarchingCubes/9.blend"),
	load("res://Blender/MarchingCubes/10.blend"),
	load("res://Blender/MarchingCubes/11.blend"),
	load("res://Blender/MarchingCubes/12.blend"),
	load("res://Blender/MarchingCubes/13.blend"),
	load("res://Blender/MarchingCubes/14.blend"),
	# all meshes below need inverted normals
	load("res://Blender/MarchingCubes/EmptyCubeFrame.blend"),
	load("res://Blender/MarchingCubes/1.blend"),
	load("res://Blender/MarchingCubes/2.blend"),
	load("res://Blender/MarchingCubes/3.blend"),
	load("res://Blender/MarchingCubes/4.blend"),
	load("res://Blender/MarchingCubes/5.blend"),
	load("res://Blender/MarchingCubes/6.blend"),
	load("res://Blender/MarchingCubes/7.blend"),
	load("res://Blender/MarchingCubes/8.blend"),
	load("res://Blender/MarchingCubes/9.blend"),
	load("res://Blender/MarchingCubes/10.blend"),
	load("res://Blender/MarchingCubes/11.blend"),
	load("res://Blender/MarchingCubes/12.blend"),
	load("res://Blender/MarchingCubes/13.blend"),
	load("res://Blender/MarchingCubes/14.blend")
]

class LookupDataProperties:
	var variant: int
	var rotation: Vector3
	
	func _init(init_variant: int, init_rotation) -> void:
		variant = init_variant
		
		if init_rotation is Array:
			rotation = Vector3(
				init_rotation[0],
				init_rotation[1],
				init_rotation[2]
			)
			return
		
		if init_rotation is Vector3:
			rotation = init_rotation
			return
		
		push_error("init_rotation must be a Vector3 or an array with at least 3 elements")

static func _get_lookup_data() -> Dictionary:
	var json_contents: String = FileAccess.get_file_as_string("res://Data/Terrain Mesh Lookup Data.json")
	var data: Dictionary = JSON.parse_string(json_contents)
	
	var lookup_data: Dictionary = {}
	for key in data:
		lookup_data[int(key)] = LookupDataProperties.new(
			data[key].variant,
			data[key].rotation
		)
	return lookup_data

static func get_mesh_node(mesh_key: int) -> Node3D:
	var properties: LookupDataProperties = lookup[mesh_key if lookup.has(mesh_key) else 0]
	var mesh_node: Node3D = variants[properties.variant].instantiate()
	mesh_node.rotate(Vector3.UP, deg_to_rad(properties.rotation.y))
	mesh_node.rotate(Vector3.RIGHT, deg_to_rad(properties.rotation.x))
	mesh_node.rotate(Vector3.BACK, deg_to_rad(properties.rotation.z))
	return mesh_node
