extends CharacterBody3D

@export var speed = 14
@export var fall_acceleration = 75
@export var jump_impulse = 20
@export var bounce_impulse = 16

var target_velocity = Vector3.ZERO

func _physics_process(delta):
	calculate_input_velocity(delta)
	
	calculate_collisions()
	
	velocity = target_velocity
	
	move_and_slide()

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
	
	return direction

func calculate_vertical_velocity(delta):
	if not is_on_floor():
		target_velocity.y = target_velocity.y - (fall_acceleration * delta)
	elif Input.is_action_just_pressed("jump"):
		target_velocity.y = jump_impulse

func calculate_collisions():
	for index in range(get_slide_collision_count()):
		var collision = get_slide_collision(index)

		if collided_with_mob_top(collision):
			var mob = collision.get_collider()
			mob.squash()
			target_velocity.y = bounce_impulse

func collided_with_mob_top(collision):
	return (
			collision.get_collider() != null
			and collision.get_collider().is_in_group("Mob")
			and Vector3.UP.dot(collision.get_normal()) > 0.1
	)
