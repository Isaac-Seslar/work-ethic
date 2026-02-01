extends Node

#Singleton that stores the stickers in your inventory

# name -> { data: StickerData, count: int } 
# NOTE: currently stores how many stickers you have of a certain type in case we
# decide to allow for multiple of a sticker type
var stickers: Dictionary = {}

func add_sticker(sticker_data : StickerData) -> void:
	if not stickers.has(sticker_data.name):
		stickers[sticker_data.name] = {
			"data" = sticker_data,
			"count" = 0
			}
	
	stickers[sticker_data.name].count += 1
	EventBus.emit_signal("inventory_changed")
	print("sticker added")

func remove_sticker(sticker_data : StickerData) -> void:
	if not stickers.has(sticker_data.name):
			return
	
	else:
		stickers[sticker_data.name].count -= 1
	
	if stickers[sticker_data.name].count == 0:
		stickers.erase(sticker_data.name)
	
	EventBus.emit_signal("inventory_changed")
