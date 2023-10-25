extends VBoxContainer

class_name PlayerInventoryUI

@onready var item_info_label = $"Top/Info Tabs/Item Info/MarginContainer/Text"

func init(inventory: PlayerInventory, columns: int) -> void:
	var aspect_ratio_container: AspectRatioContainer = $"Bottom/Inventory View/Aspect Ratio Container"
	var slot_grid: GridContainer = $"Bottom/Inventory View/Aspect Ratio Container/Slot Grid"
	
	InventoryManager.singleton.add_child(self)
	
	name = "Player Inventory [" + str(inventory.max_stacks) + "]"
	slot_grid.columns = columns
	aspect_ratio_container.ratio = float(columns) / ceil(float(inventory.max_stacks) / float(columns))
	
	for index in range(inventory.max_stacks):
		var item_slot: InventorySlot = ResourceManager.item_slot_scene.get_value().instantiate()
		item_slot.init(inventory.stacks[index])
		_connect_slot(item_slot)
		item_slot.name = "Slot " + str(index)
		slot_grid.add_child(item_slot)
	
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

func _connect_slot(slot: InventorySlot) -> void:
	slot.gui_input.connect(_slot_on_click)
	slot.mouse_entered.connect(_get_slot_on_mouse_enter(slot))
	slot.mouse_exited.connect(_slot_on_mouse_exited)

func _slot_on_click(event: InputEvent):
	if not(event is InputEventMouseButton):
		return
		
	if Player.singleton.held_stack.is_empty():
		return

	item_info_label.text = Player.singleton.held_stack.item.description

func _get_slot_on_mouse_enter(item_slot: InventorySlot):
	return func() -> void:
		if not Player.singleton.held_stack.is_empty():
			return
		
		if item_slot.item_stack_ui.item_stack.is_empty():
			return
	
		item_info_label.text = item_slot.item_stack_ui.item_stack.item.description

func _slot_on_mouse_exited() -> void:
	if not Player.singleton.held_stack.is_empty():
			return
	
	item_info_label.text = ""
