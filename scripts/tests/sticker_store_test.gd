extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	StatsManager.add_money(1000)
