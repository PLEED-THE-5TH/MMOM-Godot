extends Node3D

class_name Interactable

# Should be emitted in the child class
signal can_interact_changed(interactable: Interactable, can_interact: bool)

# Should be redefined in the child class
var prompt: Control

# Should be redefined in the child class
func can_interact() -> bool:
	return true

# Should be redefined in the child class
func interact() -> void:
	pass

func try_interact() -> bool:
	if not can_interact():
		return false
	
	interact()
	return true

# If redefined in the child class, call super() to keep functionality
func _ready() -> void:
	InteractableManager.add_interactable(self)
