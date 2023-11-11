extends CharacterBody3D

class_name ItemStackDrop

@onready var sprite: Sprite3D = $"Sprite"
@onready var timer: Timer = $"Timer"
@onready var pickup_area: Area3D = $"PickupArea"

@export var gravity: float = -1
@export var ground_friction: float = 20
@export var air_friction: float = 15

var item_stack: ItemStack:
	get:
		return item_stack

var can_pickup: bool:
	get:
		return timer.time_left <= 0

func init(init_item_stack: ItemStack) -> void:
	item_stack = init_item_stack
	
	sprite.texture = item_stack.item.icon
	position = Player.singleton.position
	
	item_stack.changed.connect(_on_item_stack_changed)

func _process(delta: float) -> void:
	_check_pickup()
	
	var friction: float = air_friction
	if is_on_floor() or is_on_wall() or is_on_ceiling():
		friction = ground_friction
	velocity.x = max(abs(velocity.x) - (friction * delta), 0) * sign(velocity.x)
	velocity.z = max(abs(velocity.z) - (friction * delta), 0) * sign(velocity.z)
	
	velocity.y += gravity
	rotate_y(delta)
	
	move_and_slide()

func _check_pickup() -> void:
	if not can_pickup:
		return
	
	if not pickup_area.overlaps_body(Player.singleton):
		return
	
	Player.singleton.inventory.auto_add(item_stack)

func _on_item_stack_changed() -> void:
	if item_stack.is_empty():
		queue_free()
