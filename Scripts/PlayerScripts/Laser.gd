extends Node3D

class_name Laser

@onready var mining_orb = $".."
@onready var mining_ray = $"../../../Camera_Mount/Camera3D/MiningRay"
@onready var laser_beam: MeshInstance3D = $LaserBeam
@onready var camera_3d = $"../../../Camera_Mount/Camera3D"
@export var sky_aim_distance := 20

var shoot = false

func _process(delta):
	gen_laser(get_end_point())

func get_end_point() -> Vector3:
	if not shoot:
		return global_position
		
	if mining_ray.is_colliding():
		return mining_ray.get_collision_point()
		
	return get_miss_point()

func gen_laser(end_point: Vector3):
	if not end_point.is_equal_approx(global_position):
		laser_beam.look_at(end_point)
	laser_beam.scale.z = laser_beam.global_position.distance_to(end_point) * 5.5

func get_miss_point() -> Vector3:
	var camera_forward: Vector3 = camera_3d.global_transform.basis.z.normalized()
	var diff: Vector3 = camera_3d.global_position - mining_orb.global_position
	var dot: float = camera_forward.dot(diff)
	var dist: float = -dot - sqrt(pow(dot, 2) - (diff.length_squared() - pow(sky_aim_distance, 2)))
	return camera_3d.global_position + (camera_forward * dist)
