extends CharacterBody3D

@export var speed = 14
@export var fall_acceleration = 75
@export var jump_impulse = 20

var target_velocity = Vector3.ZERO

func _physics_process(delta):
	var direction = calculate_direction()
	
	velocity = calculate_velocity(direction, delta)
	
	move_and_slide()

func calculate_direction():
	var direction = Vector3.ZERO
	
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_back"):
		direction.z += 1
	if Input.is_action_pressed("move_forward"):
		direction.z -= 1
	
	if direction.length() > 0:
		direction = direction.normalized()
		$Pivot.look_at(position + direction)
	
	return direction

func calculate_velocity(direction, delta):
	var target_velocity = Vector3(direction.x * speed, 0, direction.z * speed)
	target_velocity.z = direction.z * speed
	
	if not is_on_floor():
		target_velocity.y = target_velocity.y - (fall_acceleration * delta)
	elif Input.is_action_just_pressed("jump"):
	
	return target_velocity
