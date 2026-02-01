extends Button

@onready var inventory: Panel = $"../Inventory"

func _ready() -> void:
	update_text()

func _pressed() -> void:
	inventory.visible = !inventory.visible
	update_text()

func update_text() -> void:
	if inventory.visible:
		text = "Hide Inventory"
	else:
		text = "Show Inventory"
