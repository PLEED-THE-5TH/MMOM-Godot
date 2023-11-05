extends Node3D

class_name Player

static var singleton: Player:
	get:
		return singleton
		
var inventory: Inventory:
	get:
		return inventory

var held_stack: ItemStack = ItemStack.new()

func _ready():
	Player.singleton = self
	
	ResourceManager.held_stack_scene.get_value(true).instantiate().init(held_stack)
	
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
	if Input.is_action_just_pressed("Toggle Inventories"):
		InventoryManager.toggle_inventories()
	
	if Input.is_action_just_pressed("Drop"):
		held_stack.drop_at(position)
