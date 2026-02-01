extends AudioStreamPlayer2D


#@export var sounds : Array[AudioStream]

func play_for_duration():
	
	var total_length = stream.get_length()
	# Ensure we don't start in the last 2 seconds of the file
	var random_start = randf_range(0.0, total_length - 2.0)
	
	play(random_start)
	
	# Wait for the duration within the code
	await get_tree().create_timer(1.5).timeout
	
	stop()
