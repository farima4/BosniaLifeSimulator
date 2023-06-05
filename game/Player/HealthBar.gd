extends ProgressBar

var player_hp = 100

func _on_player_health_changed(amount):
	player_hp = amount

func _process(delta):
