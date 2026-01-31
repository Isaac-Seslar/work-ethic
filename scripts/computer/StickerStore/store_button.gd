extends Button
class_name StoreButton

@export var sticker_data : StickerData

@onready var sticker_image : TextureRect = $VBoxContainer/StickerImage
@onready var sticker_name : Label = $VBoxContainer/StickerName
@onready var sticker_price : Label = $VBoxContainer/StickerPrice

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sticker_image.texture = sticker_data.image
	sticker_name.text = sticker_data.name
	sticker_price.text = "$ "+str(sticker_data.price)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
