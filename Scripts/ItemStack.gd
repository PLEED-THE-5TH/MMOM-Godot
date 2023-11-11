class_name ItemStack

var item: Item:
	get:
		return item
		
var size: int = 0:
	get:
		return size

signal changed()

enum ConflictAction {
	HALT,
	REPLACE
}

func _init(init_item: Item = null, init_size: int = 1) -> void:
	if not init_item:
		return
	
	_set_item_and_size(init_item, init_size)

func clone() -> ItemStack:
	return ItemStack.new(item, size)

func set_item(new_item: Item, conflict_action: ConflictAction = ConflictAction.REPLACE) -> bool:
	if not _set_item(new_item, conflict_action):
		return false
		
	changed.emit()
	return true

func set_size(new_size: int) -> bool:
	if not _set_size(new_size):
		return false
	
	changed.emit()
	return true

# use this or `set_stack` to avoid emitting the `changed` signal twice
func set_item_and_size(new_item: Item, new_size: int, conflict_action: ConflictAction = ConflictAction.REPLACE) -> bool:
	if not _set_item_and_size(new_item, new_size, conflict_action):
		return false
	
	changed.emit()
	return true

func set_stack(item_stack: ItemStack, conflict_action: ConflictAction = ConflictAction.REPLACE) -> bool:
	return set_item_and_size(item_stack.item, item_stack.size, conflict_action)

# accepts negative numbers
func increment_size(count: int) -> bool:
	return set_size(size + count)

func combine(item_stack: ItemStack, set_if_empty: bool = false) -> bool:
	if is_empty() and set_if_empty:
		if not set_stack(item_stack):
			return false
			
		item_stack.empty()
		return true
	
	if size == item.max_stack_size:
		return false
	
	if items_conflict(item_stack):
		return false
	
	var items_added: int = min(item_stack.size, item.max_stack_size - size)
	if not increment_size(items_added):
		return false
	
	if not item_stack.increment_size(-items_added):
		size -= items_added
		return false
	
	return true

func items_conflict(item_stack: ItemStack) -> bool:
	return ItemStack.conflict(item, item_stack.item)

# returns true if the two items cannot be in the same stack
static func conflict(item1: Item, item2: Item) -> bool:
	if item1 and item2:
		return item1.name != item2.name
	else:
		return (item1 != null) != (item2 != null)

func is_empty() -> bool:
	return size == 0 or not item

func empty() -> void:
	_empty()
	changed.emit()

func drop() -> ItemStackDrop:
	var stack_drop: ItemStackDrop = ItemStackDropManager.create_drop(clone())
	empty()
	return stack_drop

func _empty() -> void:
	item = null
	size = 0

func _set_item_and_size(new_item: Item, new_size: int, conflict_action: ConflictAction = ConflictAction.REPLACE) -> bool:
	if new_size == 0:
		_empty()
		return true
	
	var old_item: Item = item
	if not _set_item(new_item, conflict_action):
		return false
	
	if is_empty():
		return true
	
	if not _set_size(new_size):
		item = old_item
		return false
	
	return true

func _set_item(new_item: Item, conflict_action: ConflictAction = ConflictAction.REPLACE) -> bool:
	var assign_item: Callable = func() -> void:
		item = new_item
		size = 1 if item else 0
	
	if ItemStack.conflict(item, new_item):
		match conflict_action:
			ConflictAction.HALT:
				return false
			ConflictAction.REPLACE:
				assign_item.call()
				return true
		return false
	
	assign_item.call()
	return true

func _set_size(new_size: int) -> bool:
	if new_size == 0:
		_empty()
		return true
		
	if is_empty():
		return false
	
	if new_size < 0:
		return false
	if new_size > item.max_stack_size:
		return false
	
	size = new_size
	return true
