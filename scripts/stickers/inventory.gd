extends Panel

@export var sticker_slot : PackedScene

@onready var grid : GridContainer = $VBoxContainer/ScrollContainer/GridContainer

func _ready() -> void:
	load_stickers_from_inventory()
	EventBus.inventory_changed.connect(refresh)
	

func refresh() -> void:
	clear_all_children(grid)
	load_stickers_from_inventory()

func load_stickers_from_inventory() -> void:
	var stickers : Dictionary = StickerManager.stickers
	
	for sticker_name in stickers:
		var sticker = stickers[sticker_name]
		add_inventory_slot(sticker.data)


func add_inventory_slot(sticker_data : StickerData):
	var slot : InventoryStickerSlot = sticker_slot.instantiate()
	slot.sticker_data = sticker_data
	grid.add_child(slot)

func clear_all_children(parent_node : Node) -> void:
	# Get all children of the parent node
	for child in parent_node.get_children():
		# Safely remove and delete the child node
		child.queue_free()
