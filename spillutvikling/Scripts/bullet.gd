extends Node2D

<<<<<<< Updated upstream
var velocity: Vector2 = Vector2.ZERO

func _process(delta):
	position += velocity * delta

func set_velocity(new_velocity: Vector2):
	velocity = new_velocity
=======
var speed = 300
var direction = Vector2.RIGHT

func _ready():
	direction = direction.rotated(rotation)

func _physics_process(delta):
	position += direction * speed * delta

func _on_Bullet_body_entered(body):
	if body.name == "Player":
		body.queue_free()
	queue_free()
>>>>>>> Stashed changes
