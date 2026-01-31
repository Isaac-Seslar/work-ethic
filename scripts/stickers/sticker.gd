extends Node2D
@export var sticker_texture : Texture2D

@onready var sprite_2d : Sprite2D = $Sprite2D
@onready var drop_shadow : Sprite2D = $DropShadow

var dragging : bool = false
var drag_offset := Vector2.ZERO
var selected : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite_2d.texture = sticker_texture
	drop_shadow.texture = sticker_texture

func _input_event(viewport : Node, event : InputEvent, shape_idx : int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed():
			dragging = true
			drag_offset = global_position - event.global_position
			sprite_2d.scale += Vector2(0.01, 0.01)
			drop_shadow.scale += Vector2(0.02, 0.02)
			drop_shadow.position += Vector2(3, 3)
			z_index = 1000
			selected = true
		elif selected:
			dragging = false
			sprite_2d.scale -= Vector2(0.01, 0.01)
			drop_shadow.scale -= Vector2(0.02, 0.02)
			drop_shadow.position -= Vector2(3, 3)
			z_index = 0
			selected = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if dragging:
		position = get_global_mouse_position() + drag_offset
