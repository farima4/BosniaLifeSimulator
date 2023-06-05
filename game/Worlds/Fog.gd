extends WorldEnvironment


func _on_day_night_day_night_status_change(status):
	var fog = preload("res://Worlds/Fog.tres")
	fog.fog_enabled = true if status else false
	fog.fog_density = 0.15
	var tween = get_tree().create_tween()
	tween.tween_property(self, "enviorement", fog, 1)
