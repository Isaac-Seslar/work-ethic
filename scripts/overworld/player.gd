extends CharacterBody2D


const SPEED = 300.0

func _ready() -> void:
	position = Vector2(500,500)
	
func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("overworld_move_left", "overworld_move_right", "overworld_move_up", "overworld_move_down")
	velocity = direction * SPEED
	if(velocity.x > 0):
		$Sprite2D.flip_h = true
	if(velocity.x < 0):
		$Sprite2D.flip_h = false
	move_and_slide()
