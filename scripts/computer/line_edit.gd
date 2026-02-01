extends LineEdit

@onready var history_log = $"../MessageBox"
@onready var keyboard_audio_player: AudioStreamPlayer2D = $"../../../../KeyboardAudioPlayer"

var boss_message_sent:bool = false
var prepended_val:String=""
var boss_intoduction_msg:bool = false

func _ready():
	
	text_submitted.connect(_on_text_submitted)
	grab_focus() # Auto-select the typing bar

func _on_text_submitted(new_text):
	var substring = "Boss:"
	
	if substring in new_text:
		_message_formater(new_text)
	else:
		prepended_val="Me: "
		StatsManager.add_money(Constants.MESSAGE_SENT_EARN)
		_message_formater(new_text, prepended_val)
		keyboard_audio_player.play_for_duration()
	
func _message_formater(new_text, prepended_val: String ="" ):
	if new_text.strip_edges() == "":
		return
	
	history_log.horizontal_alignment=0
	# Add user text to the log	
	
	history_log.append_text("\n" + prepended_val + new_text)
	clear()
	
func boss_messages():
	var message_picker = randi_range(1,5)
	var boss_message = null
	
	
	match message_picker:
		1: boss_message = "Boss: What are you doing?"
		2: boss_message = "Boss: Whats the status of your deliverables??"
		3: boss_message = "Boss: Lets circle back on that..."
		4: boss_message = "Boss: Understood. I need the ETA on the write up"
		5: boss_message = "Boss: Can you hop on a meeting real quick actually."

	if text.is_empty():
		if boss_intoduction_msg == false:
			_on_text_submitted("Boss: Hey how are you?")
			boss_intoduction_msg=true
		else:
			_on_text_submitted(boss_message)
			boss_message_sent=true
	else:
		pass
		
	
	
