extends Button
class_name StoreButton

@export var sticker_data : StickerData

@onready var sticker_image : TextureRect = $VBoxContainer/StickerImage
@onready var sticker_name : Label = $VBoxContainer/StickerName
@onready var sticker_price : Label = $VBoxContainer/StickerPrice
@onready var sold_label : Label = $SoldLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sticker_image.texture = sticker_data.image
	sticker_name.text = sticker_data.name
	sticker_price.text = "$ "+str(sticker_data.price)
	EventBus.money_changed.connect(_money_changed)
	pressed.connect(_on_pressed)
	_update_state()

func enable() -> void:
	disabled = false
	sticker_image.modulate.a = 1.0

func disable() -> void:
	disabled = true
	sticker_image.modulate.a = 0.33

func _money_changed(_amount : int) -> void:
	_update_state()

func _update_state() -> void:
	if StatsManager.get_money() < sticker_data.price or sticker_data.owned:
		disable()
	
	else:
		enable()
	
	if sticker_data.owned:
		sold_label.visible = true
		
	elif not sticker_data.owned:
		sold_label.visible = false

func _on_pressed() -> void:
	sticker_data.owned = true
	StatsManager.spend_money(sticker_data.price)
	EventBus.emit_signal("sticker_purchased", sticker_data)
	
func _process(delta: float) -> void:
	pass
