extends Button

func _on_button_down():
	#var banja_luka = preload("res://Worlds/BanjaLuka.tscn").instantiate()
	get_tree().change_scene_to_file("res://Worlds/BanjaLuka.tscn")

func _input(event):
	if Input.is_action_just_pressed("start"):
		_on_button_down()
