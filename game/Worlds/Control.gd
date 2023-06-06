extends Control

func _input(event):
	if Input.is_action_just_pressed("start"):
		_on_play_button_down()

func _on_play_button_down():
	get_tree().change_scene_to_file("res://Worlds/BanjaLuka.tscn")

func _on_exit_button_down():
	get_tree().quit()
