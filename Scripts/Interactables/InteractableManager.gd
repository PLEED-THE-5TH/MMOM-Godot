extends Control

class_name InteractableManager

static var singleton: InteractableManager

static var container: CenterContainer

static var selected_interactable: Interactable = null

func _ready() -> void:
	singleton = self
	container = $"Center Container"
	InventoryUIManager.singleton.visibility_changed.connect(_on_inventory_visibility_changed)

func _on_inventory_visibility_changed() -> void:
	visible = not InventoryUIManager.singleton.visible

static func add_interactable(interactable: Interactable) -> void:
	interactable.can_interact_changed.connect(singleton._on_can_interact_changed)
	container.add_child(interactable.prompt)

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

static func try_interact() -> bool:
	if not singleton.visible:
		return false
	
	if not selected_interactable:
		return false
	
	selected_interactable.interact()
	return true
