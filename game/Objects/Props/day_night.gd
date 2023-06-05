extends Node3D

signal day_night_status_change(status)
@onready var SunMoon = $SunMoon
@onready var Day = $Day
@onready var Night = $Night
@export var time = 20
# 0 - day
# 1 - night
var status = 0


func _ready():
	$SunMoon/Sun2.cast_shadow = false
	$SunMoon/Moon2.cast_shadow = false
	print(Day.wait_time)
	Day.wait_time = time / 2
	Night.wait_time = time / 2
	day_night_status_change.emit(status)
	start()
	
func start():
	var tween = get_tree().create_tween()
	tween.tween_property(SunMoon, "rotation", Vector3(deg_to_rad(-180), 0, 0), time / 2).as_relative()
	Day.start()

func _on_day_timeout():
	var tween = get_tree().create_tween()
	tween.tween_property(SunMoon, "rotation", Vector3(deg_to_rad(-180), 0, 0), time / 2).as_relative()
	status = 1
	day_night_status_change.emit(status)
	Night.start()



func _on_night_timeout():
	status = 0
	day_night_status_change.emit(status)
	start()
