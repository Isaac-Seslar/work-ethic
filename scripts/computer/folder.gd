extends TextureRect
class_name DesktopFolder

var file_scene = preload("res://scenes/computer/file_control.tscn")

var stored_files = [] # This acts as the folder's memory

func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	# Only highlight and accept if it is a valid file
	return typeof(data) == TYPE_DICTIONARY and data.get("type") == "file"

func _drop_data(_at_position: Vector2, data: Variant) -> void:
	if is_instance_valid(data.source_node):
		data.source_node.queue_free()
	
	var timer = Timer.new()
	add_child(timer)
	timer.one_shot = true
	timer.wait_time = 0.5 # Delay before spawning
	timer.timeout.connect(_on_timer_timeout)
	timer.start()
	
func _on_timer_timeout():
	spawn_file()
	
func spawn_file():
	var new_file_node = file_scene.instantiate()
	var parent = get_parent()
	
	parent.add_child(new_file_node)
	
	parent.move_child(new_file_node, self.get_index())
	
	new_file_node.size = Vector2(64, 64) 
	
	new_file_node.position = Vector2(0, 0)
	new_file_node.size = Vector2(1152.0, 648.0)
