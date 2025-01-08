extends Node2D


func _on_area_2d_body_entered(body: Node2D) -> void:
	
	if body.name == "CharacterBody2D-Pilota":
		
		# Hem de cridar a set_ball_velocity()
		# En set_ball_velocity() es reiniciarà la posició de la pilota
		$"CharacterBody2D-Pilota".set_ball_velocity()
