extends Control

var score = 0

func _on_mob_squashed():
	score += 1
	$ScoreLabel.text = str(score)

func _on_player_died():
	$Retry.show()
