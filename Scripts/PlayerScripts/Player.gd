extends CharacterBody3D

class_name Player

@onready var camera_mount = $Camera_Mount
@onready var animation_player = $Visuals/mixamo_base/AnimationPlayer
@onready var visuals = $Visuals
@onready var interact_ray = $Camera_Mount/Camera3D/InteractRay
@onready var pause_menu = $"../UI/PauseMenu"

var SPEED = 2
const JUMP_VELOCITY = 4.5

var walking_speed = 2
var running_speed = 3
var running = false
var freeze_camera = false
var fullscreen_toggle = false

@export var inventory_data: InventoryData
@export var sens_horizontal = 0.25
@export var sens_vertical = 0.25
@export var equip_inventory_data: InventoryDataEquip

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var health: int = 100

signal toggle_inventory()

func _ready():
	PlayerManager.player = self
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event):
	if event is InputEventMouseMotion and !freeze_camera:
		rotate_y(deg_to_rad(-event.relative.x * sens_horizontal))
		visuals.rotate_y(deg_to_rad(event.relative.x * sens_horizontal))
		camera_mount.rotate_x(deg_to_rad(-event.relative.y * sens_vertical))
	
	if Input.is_action_just_pressed("inventory"):
		toggle_inventory.emit()
	
	if Input.is_action_just_pressed("interact"):
		interact()
	
	if Input.is_action_just_pressed("esq"):
		pause_menu.toggle_pausemenu()
	
	if Input.is_action_just_pressed("ult"):
		test_func()
	
	if Input.is_action_just_pressed("f11"):
		toggle_fullscreen()

func test_func() -> void:
	print("test func used")
	pass

func toggle_fullscreen() -> void:
	if fullscreen_toggle == false:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		fullscreen_toggle = true
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		fullscreen_toggle = false

func _physics_process(delta):
	if Input.is_action_pressed("run"):
		SPEED = running_speed
		running = true
	else:
		SPEED = walking_speed
		running = false
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		if running:
			if animation_player.current_animation != "running":
				animation_player.play("running")
		else:
			if animation_player.current_animation != "walking":
				animation_player.play("walking")
		
		visuals.rotation.y = \
		lerp_angle(visuals.rotation.y, atan2(-input_dir.x, -input_dir.y), .25)
		
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		if animation_player.current_animation != "idle":
			animation_player.play("idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func interact() -> void:
	if interact_ray.is_colliding():
		interact_ray.get_collider().player_interact()

func get_drop_position() -> Vector3:
	var direction = -camera_mount.global_transform.basis.z
	return camera_mount.global_position + direction

func heal(heal_value: int) -> void:
	health += heal_value

