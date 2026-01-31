extends LineEdit

@onready var history_log = $"../MessageBox"

var boss_message_sent:bool = false

func _ready():
	text_submitted.connect(_on_text_submitted)
	grab_focus() # Auto-select the typing bar

func _on_text_submitted(new_text):
	if new_text.strip_edges() == "":
		return
	
	# Add user text to the log
	if not boss_message_sent:
		history_log.horizontal_alignment=2
	else:
		history_log.horizontal_alignment=0
		
	history_log.append_text("\n" + new_text)
	clear()
	
func boss_messages():
	var message_picker = randi_range(1,5)
	var boss_message = null
	
	match message_picker:
		1: boss_message = "What are you doing?"
		2: boss_message = "Whats the status of your deliverables??"
		3: boss_message = "Lets circle back on that..."
		4: boss_message = "Understood. I need the ETA on the write up"
		5: boss_message = "Can you hop on a meeting real quick actually."

	if text.is_empty():
		_on_text_submitted(boss_message)
		boss_message_sent=true
	else:
		pass
	
	
