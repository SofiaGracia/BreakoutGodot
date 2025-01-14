extends Node2D


func _on_area_2d_body_entered(body: Node2D) -> void:
	
	if body.name == "CharacterBody2D-Pilota":
		GameData.lives -= 1
		
		# Gestionem el final del joc
		if(GameData.lives<=0):
			$HUD/GameOverLabel.visible=true
			$HUD/Button.visible=true
			GameData.game_over=true
		
		# Hem de cridar a set_ball_velocity()
		# En set_ball_velocity() es reiniciarà la posició de la pilota
		$"CharacterBody2D-Pilota".reset_ball($"CharacterBody2D-Player")
