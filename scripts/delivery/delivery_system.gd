extends Node

var cooldown_timer: Timer
var purchase_started: bool = false
var pending_delivery_data: Array[StickerData] = []

func _ready() -> void:
	cooldown_timer = Timer.new()
	cooldown_timer.one_shot = true
	add_child(cooldown_timer)

	cooldown_timer.timeout.connect(_on_cooldown_timeout)

	EventBus.sticker_purchased.connect(_on_purchase_signal_received)

func _process(delta: float) -> void:
	if cooldown_timer.is_stopped() and purchase_started:
		deliver_sticker(pending_delivery_data.pop_front())
		
		if pending_delivery_data.size() == 0:
			purchase_started=false
		else:
			start_cooldown(Constants.DELIVERY_WAIT_TIME)
		
	else:
		pass

func _on_purchase_signal_received(received_sticker_data: StickerData) -> void:
	print(received_sticker_data.name)
	start_cooldown(Constants.DELIVERY_WAIT_TIME)
	pending_delivery_data.append(received_sticker_data)
	purchase_started=true
	
	
func deliver_sticker(recieved_sticker_data) -> void:
	EventBus.delivery_arrived.emit(recieved_sticker_data)
	
func start_cooldown(seconds: float) -> void:
	cooldown_timer.start(seconds)
	
func cancel_cooldown() -> void:
	cooldown_timer.stop()

func _on_cooldown_timeout():
	print("add to delivery inventory")
	
