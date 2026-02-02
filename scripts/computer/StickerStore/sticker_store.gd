extends Node2D

@export var sticker_data_path : String = "res://resources/sticker_data/"
@export var store_button_scene: PackedScene

@export var stickers : Array[StickerData] 

@onready var grid := $Panel/VBoxContainer/ScrollContainer/Stickers

func _ready():
	for item in stickers:
		add_store_item(item)
	#load_items_from_directory(sticker_data_path)

func load_items_from_directory(path : String):
	var dir : DirAccess = DirAccess.open(path)
	if dir == null:
		push_error("Failed to open store items directory: " + path)
		return

	dir.list_dir_begin()
	var file_name : String = dir.get_next()

	while file_name != "":
		if not dir.current_is_dir() and file_name.ends_with(".tres"):
			var full_path : String = path + file_name
			var item : Resource = load(full_path)

			if item is StickerData:
				add_store_item(item)
			else:
				push_warning(full_path + " is not ItemData")

		file_name = dir.get_next()

	dir.list_dir_end()

func add_store_item(sticker_data : StickerData):
	var button : StoreButton = store_button_scene.instantiate()
	button.sticker_data = sticker_data
	grid.add_child(button)
