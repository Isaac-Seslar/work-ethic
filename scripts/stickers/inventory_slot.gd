extends PanelContainer
class_name InventoryStickerSlot

@export var sticker_data: StickerData
@export var image : Texture2D
@export var sticker_scene : PackedScene
@onready var icon : TextureRect = $TextureRect

var dragging := false

func _ready():
	if not sticker_data == null:
		icon.texture = sticker_data.image
	
	else:
		icon.texture = image
	
	mouse_filter = Control.MOUSE_FILTER_PASS


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			var mouse_pos : Vector2 = get_global_mouse_position()
			spawn_sticker(sticker_data, mouse_pos)

func spawn_sticker(sticker_data: StickerData, mouse_pos: Vector2) -> void:
	var new_sticker: Sticker = sticker_scene.instantiate()
	new_sticker.sticker_data = sticker_data

	get_tree().current_scene.add_child(new_sticker)

	new_sticker.global_position = mouse_pos
	new_sticker.do_drag(mouse_pos)
