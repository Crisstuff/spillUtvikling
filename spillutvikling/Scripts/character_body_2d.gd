extends CharacterBody2D
class_name Player


const SPEED = 300.0
const JUMP_VELOCITY = -600.0
@onready var anim = get_node("AnimatedSprite2D")



func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction > 0:
		anim.flip_h = false#
	elif direction < 0:
		anim.flip_h = true
	if direction:
		velocity.x = direction * SPEED
		anim.play("Run")
	else:
		anim.play("Idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
func die():
	queue_free()
