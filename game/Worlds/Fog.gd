extends WorldEnvironment


func _on_day_night_day_night_status_change(status):
	#var fog = preload("res://Worlds/Fog.tres")
	#fog.fog_enabled = true if status else false
	#fog.fog_density = 0.15
	#var tween = get_tree().create_tween()
	#tween.tween_property(self, "enviorement", fog, 1)
	var is_day = status == 0
	
	environment.fog_density = 0.02 if is_day else 0.25
	environment.background_color = Color("4948ff") if is_day else Color("000004")
