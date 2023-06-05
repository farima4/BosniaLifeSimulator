extends StaticBody3D

var damage = 20

var coliding = false

signal do_damage(amount)

@onready var player_area = $"/root/World/Player/Area3D/CollisionShape3D"

func _physics_process(_delta):
	
	if coliding:
		do_damage.emit(damage)





func _on_area_3d_area_entered(player_area):
	coliding = true


func _on_area_3d_area_exited(player_area):
	coliding = false


func _on_day_night_day_night_status_change(status):
	print("day") if status == 0 else print("night")
