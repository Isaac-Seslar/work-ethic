extends Node2D

var sticker_dir : String = "res://resources/sticker_data/"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_items_from_directory(sticker_dir)
	
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
				StickerManager.add_sticker(item)
			else:
				push_warning(full_path + " is not ItemData")

		file_name = dir.get_next()

	dir.list_dir_end()
