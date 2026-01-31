extends PanelContainer

var is_dragging = false
var drag_offset = Vector2.ZERO

@onready var title_bar = $VBoxContainer/Title
@onready var close_button = $VBoxContainer/Title/Button

func _ready():
	# Connect the TitleBar's input event to our handler
	title_bar.gui_input.connect(_on_title_bar_gui_input)
	close_button.pressed.connect(queue_free)
	
	# Optional: Move window to front when clicked
	gui_input.connect(func(event): 
		if event is InputEventMouseButton and event.pressed:
			move_to_front()
	)

func _on_title_bar_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				is_dragging = true
				# Calculate the offset so the window doesn't "snap" to the mouse center
				drag_offset = get_global_mouse_position() - global_position
				move_to_front() # Bring to front when dragging starts
			else:
				is_dragging = false

func _process(delta):
	if is_dragging:
		# Move the window to the mouse position, minus the initial click offset
		global_position = get_global_mouse_position() - drag_offset
		
		# Optional: Clamp to screen bounds so you can't lose the window
		var viewport_size = get_viewport_rect().size
		global_position.x = clamp(global_position.x, 0, viewport_size.x - size.x)
		global_position.y = clamp(global_position.y, 0, viewport_size.y - size.y)
