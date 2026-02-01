extends TextureRect # Changed from Control to TextureRect for easier setup
class_name DesktopFile

# You can export these so you can change them in the Inspector per file
@export var filename: String = "document.txt"
@export_multiline var content: String = "This is some text."

func _get_drag_data(_at_position: Vector2) -> Variant:
	var preview = TextureRect.new()
	preview.texture = texture

	preview.expand_mode = expand_mode 
	preview.stretch_mode = stretch_mode
	preview.size = size 
	preview.scale = get_global_transform().get_scale()
	preview.modulate.a = 0.95
	
	var c = Control.new()
	c.add_child(preview)
	preview.position = -(preview.size * preview.scale) / 2

	set_drag_preview(c)

	return { 
		"type": "file", 
		"filename": filename,
		"content": content, 
		"source_node": self 
	} 
