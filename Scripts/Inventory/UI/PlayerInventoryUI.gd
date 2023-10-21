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
	
	var helmet_slot: RestrictedInventorySlot = $"Top/Equipment/Armor/Helmet"
	helmet_slot.init(ItemStack.new(), Helmet)
	_connect_slot(helmet_slot)
	var chestplate_slot: RestrictedInventorySlot = $"Top/Equipment/Armor/Chestplate"
	chestplate_slot.init(ItemStack.new(), Chestplate)
	_connect_slot(chestplate_slot)
	var leggings_slot: RestrictedInventorySlot = $"Top/Equipment/Armor/Leggings"
	leggings_slot.init(ItemStack.new(), Leggings)
	_connect_slot(leggings_slot)
	var boots_slot: RestrictedInventorySlot = $"Top/Equipment/Armor/Boots"
	boots_slot.init(ItemStack.new(), Boots)
	_connect_slot(boots_slot)
	
	var mining_tool_slot: RestrictedInventorySlot = $"Top/Equipment/Tools/Mining Tool"
	mining_tool_slot.init(ItemStack.new(), MiningTool)
	_connect_slot(mining_tool_slot)
	var weapon_slot: RestrictedInventorySlot = $"Top/Equipment/Tools/Weapon"
	weapon_slot.init(ItemStack.new(), Weapon)
	_connect_slot(weapon_slot)
	
	var accessory_1_slot: RestrictedInventorySlot = $"Top/Equipment/Tools/Accessories/Accessory 1"
	accessory_1_slot.init(ItemStack.new(), Accessory)
	_connect_slot(accessory_1_slot)
	var accessory_2_slot: RestrictedInventorySlot = $"Top/Equipment/Tools/Accessories/Accessory 2"
	accessory_2_slot.init(ItemStack.new(), Accessory)
	_connect_slot(accessory_2_slot)

func _connect_slot(item_slot: InventorySlot) -> void:
	item_slot.gui_input.connect(_slot_on_click)
	item_slot.mouse_entered.connect(_get_slot_on_mouse_enter(item_slot))
	item_slot.mouse_exited.connect(_slot_on_mouse_exited)

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
