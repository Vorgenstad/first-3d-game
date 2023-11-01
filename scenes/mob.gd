extends CharacterBody3D

signal squashed

@export var min_speed = 10.0
@export var max_speed = 18.0

func _physics_process(_delta):
	move_and_slide()

func initialize(start_position, player_position):
	initialize_position(start_position, player_position)
	initialize_velocity()

func initialize_position(start_position, player_position):
	look_at_from_position(start_position, player_position)
	rotate_y(randf_range(-PI / 4, PI / 4))

func initialize_velocity():
	var speed = randi_range(min_speed, max_speed)
	velocity = (Vector3.FORWARD * speed).rotated(Vector3.UP, rotation.y)
	
	$AnimationPlayer.speed_scale = speed / min_speed

func _on_visible_on_screen_notifier_3d_screen_exited():
	queue_free()
	
func squash():
	squashed.emit()
	queue_free()
