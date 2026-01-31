extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = "$0"
	EventBus.money_changed.connect(_on_money_change)

func _on_money_change(amount) -> void:
	text = "$" + str(amount)
