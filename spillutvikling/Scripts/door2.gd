extends Area2D

var enteredDoor = false

func _on_area_entered(area: Area2D) -> void:
	enteredDoor = true

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel") and enteredDoor:
		get_tree().change_scene_to_file("res://Scenes/tutorial.tscn")
