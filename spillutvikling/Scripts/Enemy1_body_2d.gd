extends CharacterBody2D
const JUMP_VELOCITY = -900.0
const SPEED = 300.0

@onready var anim = get_node("AnimatedSprite2D")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		anim.play("idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	
	
	
