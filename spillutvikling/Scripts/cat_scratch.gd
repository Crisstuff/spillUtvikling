extends Node2D

@export var attack_damage := 10 #damage value

func _ready():
	await get_tree().create_timer(0.2).timeout
	queue_free()

func _on_AttackArea_body_entered(body):
	if body.is_in_group("enemies"): 
		body.take_damage() 
