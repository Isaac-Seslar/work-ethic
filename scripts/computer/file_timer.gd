extends Timer

@export var min_time: float = 1.0
@export var max_time: float = 3.0

@onready var file: DesktopFile = $"../File"

func _ready() -> void:
	timeout.connect(_on_timeout)
	start_random_timer()
	print("ready")

func _on_timeout() -> void:
	print("timeout")
	start_random_timer()

func start_random_timer() -> void:
	print("start")
	# randf_range generates a random float between two numbers
	wait_time = randf_range(min_time, max_time)
	start(wait_time)
