<<<<<<< Updated upstream
extends CharacterBody2D

@onready var anim = get_node("AnimatedSprite2D")
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


func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player:
		anim.play("")# legg til en animajon for slåing av spilleren når de kommer for nærme
		killPlayer(area.get_parent())


	# Check if the NPC has collided with something
	if get_slide_collision_count() > 0 and not just_reversed:
		direction *= -1  # Reverse direction
		velocity.x = speed * direction  # Update velocity immediately
		just_reversed = true  # Set the flag to prevent immediate re-reversing
	else:
		just_reversed = false  # Reset the flag if no collision

func killPlayer(player):
	player.die()
	print("Reset traps here")


func _on_Area2D_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
=======
extends KinematicBody2D

var player = null
var speed = 100
var direction = 1
var bullet_speed = 300
var bullet_scene = preload("res://bullet.tscn")

func _ready():
	$Timer.start()

func _process(delta):
	if player:
		look_at(player.global_position)
		if $Timer.is_stopped():
			shoot()

func _physics_process(delta):
	move_and_slide(Vector2(direction * speed, 0))

	if is_on_wall():
		direction *= -1

func _on_DetectionArea_body_entered(body):
	if body.name == "Player":
		player = body

func _on_DetectionArea_body_exited(body):
	if body.name == "Player":
		player = null

func shoot():
	var bullet = bullet_scene.instance()
	bullet.global_position = global_position
	bullet.rotation = rotation
	bullet.linear_velocity = Vector2.RIGHT.rotated(rotation) * bullet_speed
	get_parent().add_child(bullet)
	$Timer.start()

func _on_Timer_timeout():
	if player:
		shoot()
>>>>>>> Stashed changes
