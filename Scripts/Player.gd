extends CharacterBody3D

class_name Player

var held_stack_scene: PackedScene = preload("res://Scenes/Templates/Inventory/Held Stack.tscn")

@onready var camera: Camera3D = $"CameraFocusPoint/Camera"
@onready var body: MeshInstance3D = $"Body"

@export var movement_speed: float = 5
@export var gravity: float = -1

static var singleton: Player:
	get:
		return singleton
		
var inventory: PlayerInventory:
	get:
		return inventory

static var held_stack: ItemStack = ItemStack.new()

func _ready() -> void:
	Player.singleton = self
	
	held_stack_scene.instantiate().init(held_stack)
	
	inventory = PlayerInventory.new(10 * 9, 12)
	
	var apple: Apple = Apple.new()
	var book: Book = Book.new()
	var wood_sword: WoodSword = WoodSword.new()
	
	inventory.auto_add(ItemStack.new(apple))
	inventory.auto_add(ItemStack.new(apple, 3))
	inventory.auto_add(ItemStack.new(book))
	inventory.auto_add(ItemStack.new(book, 3))
	inventory.auto_add(ItemStack.new(wood_sword))

func _process(_delta: float) -> void:
	_handle_inputs()

func _handle_inputs() -> void:
	if Input.is_action_just_pressed("Toggle Inventories"):
		InventoryManager.toggle_inventories()
	
	if Input.is_action_just_pressed("Drop"):
		if held_stack.is_empty():
			var hover_slot: InventorySlot = inventory.ui.hover_slot
			var hover_stack: ItemStack = hover_slot.item_stack_ui.item_stack
			if hover_slot and not hover_stack.is_empty():
				hover_stack.drop()
		else:
			held_stack.drop()
	
	_handle_movement()

func _handle_movement() -> void:
	if InventoryManager.inventories_visible():
		return
	
	var camera_forward: Vector2 = -Vector2(camera.global_transform.basis.z.x, camera.global_transform.basis.z.z)
	var camera_right: Vector2 = camera_forward.rotated(deg_to_rad(90))
	
	var direction: Vector2 = Vector2.ZERO
	if Input.is_action_pressed("Forward"):
		direction += camera_forward
	if Input.is_action_pressed("Backward"):
		direction -= camera_forward
	if Input.is_action_pressed("Right"):
		direction += camera_right
	if Input.is_action_pressed("Left"):
		direction -= camera_right
	
	if is_zero_approx(direction.x) and is_zero_approx(direction.y):
		_set_horizontal_velocity(Vector2.ZERO)
	else:
		direction = direction.normalized() * movement_speed
		_set_horizontal_velocity(direction)
		body.look_at(global_position + Vector3(direction.x, 0, direction.y))
	
	velocity.y += gravity
	
	move_and_slide()

func _get_horizontal_velocity() -> Vector2:
	return Vector2(velocity.x, velocity.z)

func _set_horizontal_velocity(new_velocity: Vector2) -> void:
	velocity.x = new_velocity.x
	velocity.z = new_velocity.y

func _change_horizontal_velocity(delta_velocity: Vector2) -> void:
	velocity.x += delta_velocity.x
	velocity.z += delta_velocity.y
