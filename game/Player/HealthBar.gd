extends ProgressBar

func _on_player_health_changed(health, previous_health):
	var tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_BACK)
	tween.tween_property(self, "value", health, 0.5)
