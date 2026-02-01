extends Node

var cooldown_timer: Timer
signal cooldown_finished 

func _ready() -> void:
	cooldown_timer = Timer.new()
	cooldown_timer.one_shot = true
	add_child(cooldown_timer)

	cooldown_timer.timeout.connect(_on_cooldown_timeout)

	get_node("/root/EventBus").sticker_purchased.connect(_on_purchase_signal_received)

func _on_purchase_signal_received(received_sticker_data: StickerData):
	print(received_sticker_data)
	start_cooldown(Constants.DELIVERY_WAIT_TIME)

func start_cooldown(seconds: float):
	cooldown_timer.start(seconds)

func cancel_cooldown():
	cooldown_timer.stop()

func _on_cooldown_timeout():
	print("add to delivery inventory")
	cooldown_finished.emit()
