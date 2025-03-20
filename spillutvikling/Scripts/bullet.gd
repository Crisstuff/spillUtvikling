extends Node2D

var velocity: Vector2 = Vector2.ZERO

func _process(delta):
	position += velocity * delta

func set_velocity(new_velocity: Vector2):
	velocity = new_velocity
