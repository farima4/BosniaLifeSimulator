extends Node3D

signal day_night_status_change(status)
signal day_night_cycle_length(DawnDusk, DayNight)
@onready var SunMoon = $SunMoon

@onready var Dawn = $Dawn
@onready var Day = $Day
@onready var Dusk = $Dusk
@onready var Night = $Night

@export var time = 360
# 0 - dawn
# 1 - day
# 2 - dusk
# 3 - night
var status = 0

@onready var DawnDusk = time * 0.1
@onready var DayNight = time * 0.4

func _ready():
	day_night_cycle_length.emit(DawnDusk, DayNight)
	$Dawn.wait_time = DawnDusk
	$Day.wait_time = DayNight
	$Dusk.wait_time = DawnDusk
	$Night.wait_time = DayNight
	day_night_status_change.emit(status)
	start()
	
func start():
	var tween = get_tree().create_tween()
	tween.tween_property(SunMoon, "rotation", Vector3(deg_to_rad(-360), 0, 0), time).as_relative()
	Dawn.start()

func _on_dawn_timeout():
	status = 1
	day_night_status_change.emit(status)
	Day.start()
	
func _on_day_timeout():
	status = 2
	day_night_status_change.emit(status)
	Dusk.start()
	
func _on_dusk_timeout():
	status = 3
	day_night_status_change.emit(status)
	Night.start()

func _on_night_timeout():
	status = 0
	day_night_status_change.emit(status)
	start()






