extends WorldEnvironment

var DawnDusk
var DayNight

func _on_day_night_day_night_status_change(status):
	if status == 1 or status == 3:
		return 0
	var is_Dawn = !status
	var tween = get_tree().create_tween()
	#environment.fog_enabled = !is_Dawn
	#tween.tween_property()
	tween.tween_property(environment, "background_energy_multiplier", 1 if is_Dawn else 0.02, DawnDusk)
	tween.tween_property(environment, "fog_density", 0 if is_Dawn else 0.1, DawnDusk)


func _on_day_night_day_night_cycle_length(_DawnDusk, _DayNight):
	DawnDusk = _DawnDusk
	DayNight = _DayNight
