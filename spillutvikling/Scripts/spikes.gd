extends Node2D

@export var speed = 160.0
var current_speed = 0.0

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player:
		area.get_parent().die()

func _on_player_detect_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player:
		$AnimationPlayer.play("Shake")

func fall()
