extends Button


func _on_pressed() -> void:
	#get_tree().change_scene_to_file("res://scenes/overworld/overworld.tscn")
	EventBus.switch_scene.emit(Constants.areas.ROOM)
