extends CharacterBody3D

var MouseSensitivity = 300
var mouse_relative_x = 0
var mouse_relative_y = 0

var health_max = 100
var health = health_max

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

# Weapons
var inventory = ["empty", "empty", "mele"]
var current_slot = 2
var weapon = inventory[current_slot]

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta):
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
	if speed > speed_max:
		speed = speed_max
	elif speed < speed_min:
		speed = speed_min
	
	if jump > jump_max:
		jump = jump_max
	elif jump < jump_min:
		jump = jump_min
	
	if fov > fov_max:
		fov = fov_max
	elif fov < fov_min:
		fov = fov_min
	
	
	SPEED = speed
	JUMP_VELOCITY = jump
	$Head/Camera3D.fov = fov
	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "forwards", "backwards")
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
	elif Input.is_action_just_pressed("slot1"):
		current_slot = 0
		weapon = inventory[current_slot]
	elif Input.is_action_just_pressed("slot2"):
		current_slot = 1
		weapon = inventory[current_slot]
	elif Input.is_action_just_pressed("mele"):
		current_slot = 2
		weapon = inventory[current_slot]
	elif Input.is_action_just_pressed("switch weapon"):
		if current_slot == 0:
			current_slot = 1
		else:
			current_slot = 0
		weapon = inventory[current_slot]
