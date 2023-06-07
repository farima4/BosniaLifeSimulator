extends WorldEnvironment

func _on_day_night_day_night_status_change(status):
	var is_day = false if status else true
	var tween = get_tree().create_tween()
	environment.fog_enabled = !is_day
	tween.tween_property(environment, "background_energy_multiplier", 1 if is_day else 0.02, 4)
	tween.tween_property(environment, "fog_density", 0 if is_day else 0.1, 5)
