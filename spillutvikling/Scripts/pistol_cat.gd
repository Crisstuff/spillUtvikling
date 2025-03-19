# Her legger du til alt av enemy animasjon og død
extends CharacterBody2D

@export var speed: float = 100.0
@export var patrol_distance: float = 200.0
@export var bullet_scene: PackedScene

var direction: int = 1  # 1 = høyre, -1 = venstre
var start_position: Vector2
var player_in_range: bool = false
var player_position: Vector2

func _ready():
	start_position = global_position
	

func _physics_process(delta):
	# reiner ut fysikken til enemyen 
	if not is_on_floor():
		velocity += get_gravity() * delta
	# Hvis spilleren er i nærheten, sikter og skyter
	if player_in_range:
		$Canon.look_at(player_position)
	else:
		patrol(delta)

func patrol(delta):
	# Går fram og tilbake
	velocity.x = speed * direction
	move_and_slide()

	# Bytter retning ved grense
	if abs(global_position.x - start_position.x) > patrol_distance:
		direction *= -1

func shoot():
	if bullet_scene and player_in_range:
		var bullet = bullet_scene.instantiate()
		bullet.global_position = $Canon.global_position
		bullet.direction = ($Canon.global_position - player_position).normalized() * -1
		get_tree().current_scene.add_child(bullet)

# Oppdager spilleren
func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		player_in_range = true
		player_position = body.global_position
		$Timer.start()

func _on_area_2d_body_exited(body):
	if body.is_in_group("player"):
		player_in_range = false
		$Timer.stop()

# Skyter når timeren går ut
func _on_timer_timeout():
	shoot()
