extends Node2D

var current_area = Constants.areas.ROOM

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$WindowDetectionArea.body_entered.connect(_on_window_entered)
	$WindowDetectionArea.body_exited.connect(_on_room_entered)
	$ComputerDetectionArea.body_entered.connect(_on_computer_entered)
	$ComputerDetectionArea.body_exited.connect(_on_room_entered)
	$DoorDetectionArea.body_entered.connect(_on_door_entered)
	$DoorDetectionArea.body_exited.connect(_on_room_entered)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_window_entered(body):
	current_area = Constants.areas.WINDOW
	print("Window area entered")
	print(current_area)

func _on_computer_entered(body):
	current_area = Constants.areas.COMPUTER
	print("Computer area entered")
	print(current_area)
	
func _on_door_entered(body):
	current_area = Constants.areas.DOOR
	print("Door area entered")
	print(current_area)

func _on_room_entered(body):
	current_area = Constants.areas.ROOM
	print("Room area entered")
	print(current_area)	

func _unhandled_input(event):
	if event.is_action_pressed("interact"):
		match current_area:
			Constants.areas.WINDOW:
				print("open window")
			Constants.areas.DOOR:
				print("open door")
			Constants.areas.COMPUTER:
				print("open computer")
				SceneManager.switch_scene(Constants.areas.COMPUTER)
			Constants.areas.ROOM:
				print("open room?")
