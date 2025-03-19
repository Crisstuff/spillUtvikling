# i denne legg til alt av detection og skyting av player
extends Player

var player = null
var speed = 100
var direction = 1
var bullet_speed = 300
var bullet_scene = preload("res://Entity/Bullet.tscn")

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
