extends Node2D

var current_area = Constants.areas.ROOM
var deliveries = []
var envelopes = []
var envelope_sprite = preload("res://assets/svgs/envelope.png")
@export var starting_sticker : StickerData

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$WindowDetectionArea.body_entered.connect(_on_window_entered)
	$ComputerDetectionArea.body_entered.connect(_on_computer_entered)
	$DoorDetectionArea.body_entered.connect(_on_door_entered)
	$RoomDetectionArea.body_entered.connect(_on_room_entered)
	EventBus.delivery_arrived.connect(_on_delivery_arrived)
	EventBus.delivery_arrived.emit(starting_sticker)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_window_entered(body):
	current_area = Constants.areas.WINDOW
	print("Window area entered")
	$PanelContainer/StatusText.text = "Press E to look out the windowaw"
	print(current_area)

func _on_computer_entered(body):
	current_area = Constants.areas.COMPUTER
	print("Computer area entered")
	$PanelContainer/StatusText.text = "Press E to sit at computer"
	print(current_area)
	
func _on_door_entered(body):
	current_area = Constants.areas.DOOR
	print("Door area entered")
	$PanelContainer/StatusText.text = "Press E to pick up mail"
	print(current_area)

func _on_room_entered(body):
	current_area = Constants.areas.ROOM
	print("Room area entered")
	$PanelContainer/StatusText.text = ""
	print(current_area)	

func _on_delivery_arrived(sticker_data: StickerData):
	print("overworld on delivery arrived")
	# Add Sticker to pile of envelopes
	deliveries.append(sticker_data)
	# Add an envelope sprite
	spawn_envelope()

func spawn_envelope():
	var envelope = Sprite2D.new()
	envelope.texture = envelope_sprite
	envelope.position = Vector2(159,385)
	envelopes.append(envelope)
	add_child(envelope)
	var tween = create_tween().set_parallel()
	var y_variance = randf()*30
	var x_variance = randf()*30

	tween.tween_property(envelope, "position:x", 190+x_variance, 0.4)
	tween.tween_property(envelope, "position:y", 540+y_variance, 0.4)

func collect_deliveries():
	print("Collect deliveries")
	for sticker in deliveries:
		StickerManager.add_sticker(sticker)
		print("Added " + sticker.name)
	deliveries.clear()
	for envelope in envelopes:
		envelope.queue_free()
	envelopes.clear()
	
func _unhandled_input(event):
	if event.is_action_pressed("interact"):
		match current_area:
			Constants.areas.WINDOW:
				EventBus.switch_scene.emit(Constants.areas.WINDOW)
				print("open window")
			Constants.areas.DOOR:
				collect_deliveries()
			Constants.areas.COMPUTER:
				print("open computer")
				EventBus.switch_scene.emit(Constants.areas.COMPUTER)
			Constants.areas.ROOM:
				print("You're already here")
