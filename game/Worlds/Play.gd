extends Button

func _on_button_down():
	var banja_luka = preload("res://Worlds/BanjaLuka.tscn").instantiate()
	get_tree().get_root().add_child(banja_luka)
	get_node("/root/MainMenu").free()

