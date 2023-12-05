extends Interactable

class_name Chest

@onready var interact_area: Area3D = $"Interact Area"

var current_can_interact: bool = false
var previous_can_interact: bool = false

var inventory: Inventory
var inventory_ui: Control

func _ready() -> void:
	prompt = load("res://Scenes/Templates/Chest/Chest Prompt.tscn").instantiate()
	prompt.hide()
	
	inventory = Inventory.new(3 * 3, 3, self)
	
	inventory_ui = load("res://Scenes/Templates/Chest/Chest Inventory.tscn").instantiate()
	inventory_ui.get_node("Margin Container/Square Container").add_child(inventory.ui)
	
	can_interact_changed.connect(_on_can_interact_changed)
	
	super()

func can_interact() -> bool:
	return current_can_interact

func interact() -> void:
	InventoryUIManager.set_bottom_right(inventory_ui)
	InventoryUIManager.show_inventories()

func _on_can_interact_changed(_interactable: Interactable, _can_interact: bool) -> void:
	if current_can_interact:
		return
	
	var bottom_right = InventoryUIManager.singleton.bottom_right
	if bottom_right.get_child_count() > 0 and bottom_right.get_child(0) == inventory_ui:
		InventoryUIManager.set_bottom_right(null)

func _physics_process(_delta: float) -> void:
	current_can_interact = interact_area.overlaps_body(Player.singleton) and _player_can_see()
	
	if previous_can_interact == current_can_interact:
		return
	
	previous_can_interact = current_can_interact
	can_interact_changed.emit(self, current_can_interact)

func _player_can_see() -> bool:
	var space_state: PhysicsDirectSpaceState3D = get_world_3d().direct_space_state
	var query: PhysicsRayQueryParameters3D = PhysicsRayQueryParameters3D.create(global_position, Player.singleton.global_position)
	var result: Dictionary = space_state.intersect_ray(query)
	return result["collider"] == Player.singleton
