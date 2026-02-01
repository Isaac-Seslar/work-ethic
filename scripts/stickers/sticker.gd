extends Node2D
class_name Sticker

@export var sticker_data : StickerData

@onready var sprite_2d : Sprite2D = $Sprite2D
@onready var drop_shadow : Sprite2D = $DropShadow

var sticker_texture : Texture2D

var dragging : bool = false
var drag_offset := Vector2.ZERO
var selected : bool = false
@onready var audio_player : AudioStreamPlayer2D = $AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sticker_texture = sticker_data.image
	
	sprite_2d.texture = sticker_texture
	drop_shadow.texture = sticker_texture

func _input_event(_viewport : Node, event : InputEvent, _shape_idx : int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed():
			do_drag(event.global_position)
		elif selected:
			print("released")
			stop_drag()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if selected:
			stop_drag()

func _process(_delta: float) -> void:
	if dragging:
		position = get_global_mouse_position() + drag_offset

func do_drag(event_global_position : Vector2) -> void:
	dragging = true
	drag_offset = global_position - event_global_position
	sprite_2d.scale += Vector2(0.01, 0.01)
	drop_shadow.scale += Vector2(0.02, 0.02)
	drop_shadow.position += Vector2(3, 3)
	z_index = 1000
	selected = true
	audio_player.play()

func stop_drag() -> void:
	dragging = false
	sprite_2d.scale -= Vector2(0.01, 0.01)
	drop_shadow.scale -= Vector2(0.02, 0.02)
	drop_shadow.position -= Vector2(3, 3)
	z_index = 10
	selected = false
