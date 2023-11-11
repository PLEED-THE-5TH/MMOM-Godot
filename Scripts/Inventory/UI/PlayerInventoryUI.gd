extends VBoxContainer

class_name PlayerInventoryUI

var inventory_slot_scene: PackedScene = preload("res://Scenes/Templates/Inventory/Inventory Slot.tscn")

@onready var item_description_label: RichTextLabel = $"Top/Info Tabs/Item Info/MarginContainer/VBoxContainer/Description"
@onready var item_name_label: Label = $"Top/Info Tabs/Item Info/MarginContainer/VBoxContainer/Name"

var hover_slot: InventorySlot

func init(inventory: PlayerInventory, columns: int) -> void:
	var aspect_ratio_container: AspectRatioContainer = $"Bottom/Inventory View/Aspect Ratio Container"
	var slot_grid: GridContainer = $"Bottom/Inventory View/Aspect Ratio Container/Slot Grid"
	
	InventoryManager.singleton.add_child(self)
	
	name = "Player Inventory [" + str(inventory.max_stacks) + "]"
	slot_grid.columns = columns
	aspect_ratio_container.ratio = float(columns) / ceil(float(inventory.max_stacks) / float(columns))
	
	for index in range(inventory.max_stacks):
		var inventory_slot: InventorySlot = inventory_slot_scene.instantiate()
		inventory_slot.init(inventory.stacks[index])
		_connect_slot(inventory_slot)
		inventory_slot.name = "Slot " + str(index)
		slot_grid.add_child(inventory_slot)
	
	var restricted_slot_types: Dictionary = {
		$"Top/Equipment/Armor/Helmet": Helmet,
		$"Top/Equipment/Armor/Chestplate": Chestplate,
		$"Top/Equipment/Armor/Leggings": Leggings,
		$"Top/Equipment/Armor/Boots": Boots,
		$"Top/Equipment/Tools/Mining Tool": MiningTool,
		$"Top/Equipment/Tools/Weapon": Weapon,
		$"Top/Equipment/Tools/Accessories/Accessory 1": Accessory,
		$"Top/Equipment/Tools/Accessories/Accessory 2": Accessory
	}
	
	for slot in restricted_slot_types:
		slot.init(ItemStack.new(), restricted_slot_types[slot])
		_connect_slot(slot)
	
	Player.held_stack.changed.connect(_on_held_stack_changed)

func _connect_slot(slot: InventorySlot) -> void:
	slot.mouse_entered.connect(_get_slot_on_mouse_enter(slot))
	slot.mouse_exited.connect(_slot_on_mouse_exited)
	slot.item_stack_ui.item_stack.changed.connect(_get_slot_on_stack_change(slot))

func _update_item_info(item_stack: ItemStack) -> void:
	if item_stack == null or item_stack.is_empty():
		item_name_label.text = ""
		item_description_label.text = ""
		return
	
	# TODO:
	# 1. item name and item description change sizes in the ui
	# 2. mouse hover is being detected when the mouse is not hovering on the slot icon
	var item: Item = item_stack.item
	item_name_label.text = item.name
	item_description_label.text = item.description

func _on_held_stack_changed() -> void:
	var held_stack: ItemStack = Player.held_stack
	
	if not held_stack.is_empty():
		_update_item_info(held_stack)
		return
	
	var hover_stack: ItemStack = hover_slot.item_stack_ui.item_stack
	if hover_slot and not hover_stack.is_empty():
		_update_item_info(hover_stack)
		return
	
	if item_description_label.text.is_empty():
		return
	
	_update_item_info(null)

func _get_slot_on_stack_change(inventory_slot: InventorySlot) -> Callable:
	return func() -> void:
		if not Player.held_stack.is_empty():
			return
		
		if inventory_slot != hover_slot:
			return
		
		_update_item_info(inventory_slot.item_stack_ui.item_stack)

func _get_slot_on_mouse_enter(inventory_slot: InventorySlot) -> Callable:
	return func() -> void:
		hover_slot = inventory_slot
		
		if not Player.held_stack.is_empty():
			return
		
		var item_stack: ItemStack = inventory_slot.item_stack_ui.item_stack
		if item_stack.is_empty():
			return
		
		_update_item_info(item_stack)

func _slot_on_mouse_exited() -> void:
	hover_slot = null
	
	if not Player.held_stack.is_empty():
		return
	
	if item_description_label.text.is_empty():
		return
	
	_update_item_info(null)
