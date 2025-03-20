extends CharacterBody2D

@export var speed: float = 100.0  # NPC movement speed
var direction: int = -1  # Start moving left (-1 = left, 1 = right)
var just_reversed: bool = false  # To prevent immediate re-reversing

func _physics_process(delta: float) -> void:
	# Apply gravity if not on the floor
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Move the NPC in the current direction
	velocity.x = speed * direction
	move_and_slide()

	# Check if the NPC has collided with something
	if get_slide_collision_count() > 0 and not just_reversed:
		direction *= -1  # Reverse direction
		velocity.x = speed * direction  # Update velocity immediately
		just_reversed = true  # Set the flag to prevent immediate re-reversing
	else:
		just_reversed = false  # Reset the flag if no collision
		
func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player:
		killPlayer(area.get_parent())

func killPlayer(player):
	player.die()
	print("Reset traps here")
