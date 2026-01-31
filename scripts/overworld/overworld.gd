extends Node2D



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$WindowDetectionArea.body_entered.connect(_on_window_entered)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_window_entered(body):
	print("Window area entered")
