extends Node2D



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$WindowDetectionArea.body_entered.connect(_on_window_entered)
	$ComputerDetectionArea.body_entered.connect(_on_computer_entered)
	$DoorDetectionArea.body_entered.connect(_on_door_entered)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_window_entered(body):
	print("Window area entered")

func _on_computer_entered(body):
	print("Computer area entered")
	
func _on_door_entered(body):
	print("Door area entered")
