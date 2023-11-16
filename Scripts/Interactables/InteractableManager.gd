extends Node

class_name InteractableManager

static var singleton: InteractableManager

static var selected_interactable: Interactable = null

func _ready() -> void:
	singleton = self

static func add_interactable(interactable: Interactable) -> void:
	interactable.can_interact_changed.connect(singleton._on_can_interact_changed)
	singleton.add_child(interactable.prompt)

func _on_can_interact_changed(interactable: Interactable, can_interact: bool) -> void:
	if not can_interact:
		if interactable == selected_interactable:
			selected_interactable.prompt.visible = false
			selected_interactable = null
		return
	
	if not selected_interactable:
		selected_interactable = interactable
		selected_interactable.prompt.visible = true
		return
	
	var player_position: Vector3 = Player.singleton.global_position
	if interactable.global_position.distance_to(player_position) < selected_interactable.global_position.distance_to(player_position):
		selected_interactable.prompt.visible = false
		selected_interactable = interactable
		selected_interactable.prompt.visible = true
