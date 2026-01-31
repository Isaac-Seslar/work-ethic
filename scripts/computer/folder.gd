extends TextureRect
class_name DesktopFolder

var stored_files = [] # This acts as the folder's memory

func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	# Only highlight and accept if it is a valid file
	return typeof(data) == TYPE_DICTIONARY and data.get("type") == "file"

func _drop_data(_at_position: Vector2, data: Variant) -> void:
	var new_file = {
		"filename": data.filename,
		"content": data.content
	}
	stored_files.append(new_file)
	
	# 2. Delete the original file icon
	var source = data.source_node
	if is_instance_valid(source):
		source.queue_free()
