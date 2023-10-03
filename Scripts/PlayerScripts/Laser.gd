extends Node3D

@onready var mining_orb = $".."
@onready var mining_ray = $"../../../Camera_Mount/Camera3D/MiningRay"
@onready var laser_beam = $LaserBeam
@onready var camera_3d = $"../../../Camera_Mount/Camera3D"

#func _process(delta: float) -> void:
#	var cam_pos = camera_3d.global_position
#	var orb_pos = mining_orb.global_position
#	var mray_hitpoint = mining_ray.get_collision_point()
#
#
#
#	laser_beam.global_transform.origin = mray_hitpoint
#	laser_beam.mesh.height = mray_hitpoint.x
#
#	pass

@export var laser_origin_node: Node3D
@export var max_laser_range := 20
@export var sky_aim_distance := 20

func draw_line(start: Vector3, end:Vector3, start_radius: float, end_radius: float):
	# replace with your logic here
	# probably update the positions of a line renderer node
	pass

func _process(delta):
	
	# replace this with your raycast from camera logic!
	var did_hit = false;
	var hit_point = Vector3(0,10,0)
	
	var world_aim_point = Vector3.ZERO
	if did_hit:
		world_aim_point = hit_point
	else:
		# aim over an arbitrary position. this makes more sense for projectiles than a laser
		var camera_forward = (camera_3d.global_transform.basis.z) # may have to flip the sign here
		world_aim_point = camera_3d.global_position + max_laser_range * camera_forward
	
	if did_hit:
		var start = mining_orb.global_position
		var end =  world_aim_point
		var laser_length = start.distance_to(end)
		
		var start_radius = 1.0
		var end_radius = 0.5
		draw_line(start, end, start_radius, end_radius)
	else:
		# logic here up to you - abruptly turning off the laser if you go over sky might be weird
		pass
