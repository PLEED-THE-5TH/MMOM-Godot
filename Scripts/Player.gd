extends CharacterBody3D

class_name Player

@onready var camera: Camera3D = $"Camera Focus Point/Camera"
@onready var body: MeshInstance3D = $"Body"

@export var movement_speed: float = 5
@export var gravity: float = -1

static var singleton: Player

var inventory: Inventory

func _ready() -> void:
	Player.singleton = self
	
	inventory = Inventory.new(12 * 8, 12, self)
	PlayerInventoryUI.singleton.init(inventory)
	
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
	var held_stack: ItemStack = InventoryUIManager.singleton.held_item_stack_ui.item_stack
	
	if Input.is_action_just_pressed("Toggle Inventories"):
		InventoryUIManager.toggle_inventories()
	
	if Input.is_action_just_pressed("Drop"):
		if held_stack.is_empty():
			var hover_stack: ItemStack = InventoryUIManager.hover_item_stack
			if hover_stack:
				hover_stack.drop()
		else:
			held_stack.drop()
	
	if Input.is_action_just_pressed("Interact"):
		InteractableManager.try_interact()
	
	_handle_movement()

func _handle_movement() -> void:
	if InventoryUIManager.singleton.visible:
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

func _set_horizontal_velocity(new_velocity: Vector2) -> void:
	velocity.x = new_velocity.x
	velocity.z = new_velocity.y
