extends Node2D

# Export variables for customization
@export var bullet_scene: PackedScene
@export var shoot_cooldown: float = 1.0
@export var bullet_speed: float = 200.0

# Internal variables
var player: Node2D = null
var can_shoot: bool = true

# Nodes
@onready var shoot_timer: Timer = $Timer
@onready var bullet_spawn: Marker2D = $Marker2D  # Updated to match the node name

func _ready():
	# Debugging: Print the path of the kanonfeste node
	print("Kanonfeste path: ", get_path())
	
	# Debugging: Check if BulletSpawn exists
	if bullet_spawn:
		print("BulletSpawn found at path: ", bullet_spawn.get_path())
	else:
		print("BulletSpawn not found! Check the scene tree.")
	
	# Set up the shoot timer
	shoot_timer.wait_time = shoot_cooldown
	shoot_timer.connect("timeout", self._on_shoot_timer_timeout)

func _on_Area2D_body_entered(_body: Node2D):
	print("Body entered:", _body.name)
	if _body.is_in_group("player"):
		player = _body
		try_shoot()

func _on_Area2D_body_exited(_body: Node2D):
	print("Body exited:", _body.name)
	if _body == player:
		player = null

func try_shoot():
	if can_shoot and player:
		print("Trying to shoot")
		shoot()
		can_shoot = false
		shoot_timer.start()

func shoot():
	print("Shooting bullet")
	if bullet_scene and player:
		# Instantiate the bullet
		var bullet = bullet_scene.instantiate()
		get_parent().add_child(bullet)
		bullet.global_position = bullet_spawn.global_position
		
		# Calculate direction to player
		var direction = (player.global_position - bullet_spawn.global_position).normalized()
		bullet.set_velocity(direction * bullet_speed)
		
		# Rotate the cannon towards the player
		rotation = direction.angle()

func _on_shoot_timer_timeout():
	print("Shoot cooldown over")
	can_shoot = true
	if player:
		try_shoot()
