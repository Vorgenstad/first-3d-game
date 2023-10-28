extends Node

@export var mob_scene: PackedScene

func _on_spawn_timer_timeout():
	var mob = mob_scene.instantiate()

	var mob_spawn_location = $SpawnPath.get_node("SpawnLocation")
	mob_spawn_location.progress_ratio = randf()

	mob.initialize(mob_spawn_location.position, $Player.position)

	add_child(mob)
