extends TextureRect # Changed from Control to TextureRect for easier setup
class_name DesktopFile

# You can export these so you can change them in the Inspector per file
@export var filename: String = "document.txt"
@export_multiline var content: String = "This is some text."

func _get_drag_data(_at_position: Vector2) -> Variant:
	# 1. Create the visual preview
	var preview = TextureRect.new()
	preview.texture = texture # Use the same icon as this node
	preview.size = size
	preview.scale.x = 0.2
	preview.scale.y = 0.2
	preview.modulate.a = 0.95
	
	# Center the preview on the mouse
	var c = Control.new()
	c.add_child(preview)
	preview.position = -0.1* size
	set_drag_preview(c)
	
	# 2. Return the data payload
	return { 
		"type": "file", 
		"filename": filename,
		"content": content, 
		"source_node": self 
	}
	
#func spawn_file():
	#var new_file = TextureRect.new()
	#new_file.texture = load("res://assets/computer/file.png")
	#new_file.texture = texture
	##texture_rect.rect_position = Vector2(820, 217)  # Set position
	#add_child(new_file)   
