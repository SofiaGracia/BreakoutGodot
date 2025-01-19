extends Node2D

#Gastar la variable
var nivell = GameData.current_level

func _on_area_2d_body_entered(body: Node2D) -> void:
	
	if body.name == "CharacterBody2D-Pilota":
		GameData.lives -= 1
		# Gestionem el final del joc
		if(GameData.lives<=0):
			GameData.swiping = false
			$HUD/GameOverLabel.visible=true
			$HUD/Button.visible=true
			GameData.game_over=true
		# Hem de cridar a set_ball_velocity()
		# En set_ball_velocity() es reiniciarà la posició de la pilota
		$"CharacterBody2D-Pilota".reset_ball($"CharacterBody2D-Player")


func _on_area_2d_2_limit_heart_body_entered(body: Node2D) -> void:
	if body.is_in_group("hearts"):
		body.destroy()
func _process(delta: float) -> void:
	if GameData.joc_superat == true:
		$HUD/WinLabel.visible = true
		$HUD/Button.visible = true
