extends Camera3D

@onready var focus_point: Node3D = $"../../Camera Focus Point"

func _input(event: InputEvent) -> void:
	if InventoryUIManager.singleton.visible:
		return
	
	var motion_event: InputEventMouseMotion = event as InputEventMouseMotion
	
	if not motion_event:
		return
	
	focus_point.rotate_object_local(Vector3.UP, deg_to_rad(-motion_event.relative.x * SettingsManager.mouse_sensitivity))
	focus_point.rotate_object_local(Vector3.RIGHT, deg_to_rad(-motion_event.relative.y * SettingsManager.mouse_sensitivity))
	focus_point.rotation.x = clampf(focus_point.rotation.x, -1, 1)
	focus_point.rotation.z = 0
