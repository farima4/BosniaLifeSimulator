extends CharacterBody3D

signal health_changed(amount)

var health_max = 100
var health = health_max

func kill():
	get_tree().change_scene_to_file("res://Worlds/MainMenu.tscn")

func set_health(amount):
	health = clamp(amount, 0, health_max)
	health_changed.emit(health)
	if health == 0:
		kill()
		
func damage(dmg):
	if Invincibility.is_stopped():
		Invincibility.start()
		set_health(health - dmg)
		

@onready var Invincibility = $Invincibility

var ControllerSensitivity = 20

var MouseSensitivity = 300
var mouse_relative_x = 0
var mouse_relative_y = 0

var fov_min = 80
var fov = fov_min
var fov_max = fov_min + (fov_min * 0.3)

var speed_min = 5
var speed = speed_min
var speed_max = speed_min * 2

var jump_min = 4.5
var jump = jump_min
var jump_max = jump + (jump * 0.1)

var SPEED = speed
var JUMP_VELOCITY = jump

@onready var head = $Head

# Weapons
var weapons = {
	"empty" : preload("res://Weapons/empty/weapon.tscn").instantiate(),
	"knife" : preload("res://Weapons/knife/weapon.tscn").instantiate()
}
var inventory = ["empty", "empty", "knife"]
var current_slot = 2
var weapon = inventory[current_slot]

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	weapon = weapons[inventory[current_slot]]
	head.get_child(0).add_child(weapon)

func _physics_process(delta):
	var axis_vector = Vector2.ZERO
	axis_vector.x = Input.get_action_strength("look_right") - Input.get_action_strength("look_left")
	axis_vector.y = Input.get_action_strength("look_down") - Input.get_action_strength("look_up")
	rotation.y -= axis_vector.x / ControllerSensitivity
	$Head/Camera3D.rotation.x -= axis_vector.y / ControllerSensitivity
	$Head/Camera3D.rotation.x = clamp($Head/Camera3D.rotation.x, deg_to_rad(-90), deg_to_rad(90))
		
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
		
	# Handle Sprint
	if Input.is_action_pressed("sprint"):
		speed += 1
		jump += 0.05
		fov += 0.5
	else:
		speed -= 2
		jump -= 0.25
		fov -= 1.5
	
	# Keeps speed, jump and fov under control
	speed = clamp(speed, speed_min, speed_max)
	jump = clamp(jump, jump_min, jump_max)
	fov = clamp(fov, fov_min, fov_max)
	
	
	SPEED = speed
	JUMP_VELOCITY = jump
	$Head/Camera3D.fov = fov
	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.

	var input_dir = Input.get_vector("left", "right", "forwards", "backwards")
	#var input_dir = Vector3.ZERO
	input_dir.x *= abs(Input.get_action_strength("right") - Input.get_action_strength("left")) * 10
	input_dir.y *= abs(Input.get_action_strength("backwards") - Input.get_action_strength("forwards")) * 10
	#input_dir = input_dir.normalized() if input_dir.length() > 1 else input_dir
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED 
		velocity.z = direction.z * SPEED 
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED) 
		velocity.z = move_toward(velocity.z, 0, SPEED) 

	move_and_slide()

func _input(event):
	if event is InputEventMouseMotion:
		rotation.y -= event.relative.x / MouseSensitivity
		$Head/Camera3D.rotation.x -= event.relative.y / MouseSensitivity
		$Head/Camera3D.rotation.x = clamp($Head/Camera3D.rotation.x, deg_to_rad(-90), deg_to_rad(90))
		mouse_relative_x = clamp(event.relative.x, -50, 50)
		mouse_relative_y = clamp(event.relative.y, -50, 50)
	elif Input.is_action_just_pressed("slot1") and current_slot != 0:
		current_slot = 0
		weapon = weapons[inventory[current_slot]]
		switch_weapon(weapon)
	elif Input.is_action_just_pressed("slot2") and current_slot != 1:
		current_slot = 1
		weapon = weapons[inventory[current_slot]]
		switch_weapon(weapon)
	elif Input.is_action_just_pressed("mele") and current_slot != 2:
		current_slot = 2
		weapon = weapons[inventory[current_slot]]
		switch_weapon(weapon)
	elif Input.is_action_just_pressed("switch weapon"):
		if current_slot == 0:
			current_slot = 1
		else:
			current_slot = 0
		weapon = weapons[inventory[current_slot]]
		switch_weapon(weapon)


func _on_take_damage():
	pass # Replace with function body.

func switch_weapon(weapon):
	head.get_child(0).remove_child($Head/Camera3D/Weapon)
	head.get_child(0).add_child(weapon)
	
func get_weapon():
	pass
