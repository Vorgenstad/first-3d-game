extends Node

@export var mob_scene: PackedScene

func _on_spawn_timer_timeout():
	var mob = mob_scene.instantiate()

	var mob_spawn_location = $SpawnPath.get_node("SpawnLocation")
	mob_spawn_location.progress_ratio = randf()
	
	mob.initialize(mob_spawn_location.position, $Player.position)

	add_child(mob)
	
	mob.squashed.connect($UI._on_mob_squashed.bind())

func _on_player_died():
	$SpawnTimer.stop()

func _on_retry_button_pressed():
	get_tree().reload_current_scene()
