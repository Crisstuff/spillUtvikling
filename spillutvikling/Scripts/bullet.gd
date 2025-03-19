extends Area2D

@export var speed: float = 300.0
var direction: Vector2 = Vector2.ZERO

func _process(delta):
	global_position += direction * speed * delta

func _on_area_entered(area):
	if area.is_in_group("player"):
		area.queue_free()  # Skader spilleren (kan utvides)
		queue_free()  # Fjerner kulen

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()  # Fjerner kulen når den forlater skjermen
