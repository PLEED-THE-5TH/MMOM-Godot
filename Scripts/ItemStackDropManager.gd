extends Node

class_name ItemStackDropManager

var item_stack_drop_scene: PackedScene = preload("res://Scenes/Templates/Item Stack Drop.tscn")

static var singleton: ItemStackDropManager

@export var expulsion_force: Vector2 = Vector2(5, 8)

func _ready() -> void:
	singleton = self

static func create_drop(item_stack: ItemStack) -> ItemStackDrop:
	var drop: ItemStackDrop = singleton.item_stack_drop_scene.instantiate()
	singleton.add_child(drop)
	drop.init(item_stack)
	drop.velocity = (Vector3.UP * singleton.expulsion_force.x) + (-Player.singleton.body.global_transform.basis.z * singleton.expulsion_force.y)
	return drop
