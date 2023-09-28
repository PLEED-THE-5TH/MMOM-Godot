extends Resource
class_name SlotData

const Max_Stack_Size: int = 99

@export var item_data: ItemData
@export_range(1, Max_Stack_Size) var quantity: int = 1
