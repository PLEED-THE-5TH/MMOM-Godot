extends Interactable

class_name Chest

@onready var interact_area: Area3D = $"Interact Area"

var previous_can_interact: bool = false

func _ready() -> void:
	prompt = load("res://Scenes/Templates/Chest Prompt.tscn").instantiate()
	super()

func can_interact() -> bool:
	return interact_area.overlaps_body(Player.singleton) and _player_can_see()

func interact() -> void:
	# TODO
	pass

func _physics_process(_delta: float) -> void:
	var current_can_interact: bool = can_interact()
	
	if previous_can_interact == current_can_interact:
		return
	
	previous_can_interact = current_can_interact
	can_interact_changed.emit(self, current_can_interact)

func _player_can_see() -> bool:
	var space_state = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(Player.singleton.camera.global_position, global_position)
	var result = space_state.intersect_ray(query)
	print(result)
	return true
