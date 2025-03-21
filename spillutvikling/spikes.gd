extends Node2D

func _on_area_2d_2_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player:
		get_tree().change_scene_to_file("res://Scenes/tittle_screen.tscn")
		area.get_parent().die()
