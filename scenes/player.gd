extends CharacterBody3D

signal died

@export var speed = 14
@export var fall_acceleration = 75
@export var jump_impulse = 20
@export var bounce_impulse = 16

var target_velocity = Vector3.ZERO

func _physics_process(delta):
	calculate_input_velocity(delta)
	
	velocity = target_velocity
	
	move_and_slide()
	
	$Pivot.rotation.x = PI / 6 * velocity.y / jump_impulse

func calculate_input_velocity(delta):
	calculate_horizontal_velocity()
	
	calculate_vertical_velocity(delta)

func calculate_horizontal_velocity():
	var direction = calculate_direction()
	
	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed

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
		$AnimationPlayer.speed_scale = 4
	else:
		$AnimationPlayer.speed_scale = 1
	
	return direction

func calculate_vertical_velocity(delta):
	if not is_on_floor():
		target_velocity.y = target_velocity.y - (fall_acceleration * delta)
	elif Input.is_action_just_pressed("jump"):
		target_velocity.y = jump_impulse

func die():
	died.emit()
	queue_free()

func _on_mob_detector_body_entered(_body):
	die()

func _on_hurtbox_body_entered(body):
	body.squash()
	target_velocity.y = bounce_impulse
