extends StaticBody3D

var damage = -1

var coliding = false

signal do_damage(amount)

@onready var player_area = $"/root/World/Player/Area3D/CollisionShape3D"

func _physics_process(delta):
	
	if coliding:
		do_damage.emit(damage)




func _on_area_3d_area_entered(player_area):
	coliding = true


func _on_area_3d_area_exited(player_area):
	coliding = false
