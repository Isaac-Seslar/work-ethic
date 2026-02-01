extends AudioStreamPlayer2D

@export var sounds : Array[AudioStream]

func play_random_sound():
	if sounds.size() > 0:
		# pick_random() is the cleanest way to grab a random element
		stream = sounds.pick_random()
		play()
	else:
		print("No sounds assigned in the Inspector!")
