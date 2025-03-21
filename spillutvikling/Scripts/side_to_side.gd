extends CharacterBody2D

@export var speed: float = 100.0  # NPC movement speed
var direction: int = 1  # Start moving left (-1 = left, 1 = right)
var just_reversed: bool = false  # To prevent immediate re-reversing

@onready var anim = $AnimatedSprite2D  # Assuming the sprite node is named "AnimatedSprite2D"

func _physics_process(delta: float) -> void:
	# Move the NPC in the current direction
	velocity.x = speed * direction
	move_and_slide()

	# Check if the NPC has collided with something
	if get_slide_collision_count() > 0 and not just_reversed:
		direction *= -1  # Reverse direction
		velocity.x = speed * direction  # Update velocity immediately
		just_reversed = true  # Set the flag to prevent immediate re-reversing
		# Flip the sprite based on the new direction
		if direction > 0:
			anim.flip_h = true  # Face right
		else:
			anim.flip_h = false  # Face left
	else:
		just_reversed = false  # Reset the flag if no collision

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player:
		killPlayer(area.get_parent())

func _on_area_2d_area_entered(area: Area2D) -> void:
	# Check if the area belongs to the player
	if area.get_parent() is Player:
		# Kill the enemy when the player hits the Area2D
		die()

func die():
	# Remove the enemy from the scene
	queue_free()

func killPlayer(player):
	get_tree().change_scene_to_file("res://Scenes/tittle_screen.tscn")
	player.die()
	print("Reset traps here")
