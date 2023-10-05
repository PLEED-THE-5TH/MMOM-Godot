extends Node3D

@onready var mining_orb = $".."
@onready var mining_ray = $"../../../Camera_Mount/Camera3D/MiningRay"
@onready var laser_beam: MeshInstance3D = $LaserBeam
@onready var camera_3d = $"../../../Camera_Mount/Camera3D"
@export var max_laser_range := 20
@export var sky_aim_distance := 20

func _process(delta):
	gen_laser(mining_ray.get_collision_point() if mining_ray.is_colliding() else get_laser_sky_dist())

func gen_laser(end_point):
	var laser_length = mining_orb.global_position.distance_to(end_point)
	var start_radius = 1.0
	var end_radius = 0.5
	var mid_point = (end_point + mining_orb.global_position) / 2
	
	laser_beam.look_at_from_position(mid_point,  end_point)
	#laser_beam.scale.y = mining_orb.global_position.distance_to(end_point) * 2
	#laser_beam.transform = laser_beam.transform.rotated_local(Vector3.RIGHT, 90)

func get_laser_sky_dist() -> Vector3:
	var diff = camera_3d.global_position - mining_orb.global_position
	var dot = camera_3d.basis.z.dot(diff)
	var dist = -dot + sqrt(pow(dot, 2) - (diff.length_squared() - pow(max_laser_range, 2)))
	return camera_3d.global_position + camera_3d.basis.z * dist
