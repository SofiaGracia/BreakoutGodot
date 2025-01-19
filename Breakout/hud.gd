extends CanvasLayer

var ball = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# En iniciar l'script, connectem aquest per a que escolte les senyals
	GameData.connect("lives_changed", Callable(self, "_on_lives_changed"))
	GameData.connect("score_changed", Callable(self, "_on_score_changed"))
	$Button.connect("pressed", Callable(self, "_on_BotoReinici_pressed"))
	if GameData.boto_start_amagat == false:
		$StartButton.connect("pressed",Callable(self,"start_game"))
	
func _on_lives_changed(vides):
	# Quan es modifica el nombre de vides, repintem les vides restants
	# Ho farem a un nou Script associat al node *ControlVides* que tenim creat.
	$ControlVides.pinta_vides(vides)
	
func _on_score_changed(new_score):
	# Quan es modifique la puntuació, actualitzarem aquesta a la UI
	$ScoreLabel.text = str(new_score)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func _on_BotoReinici_pressed():
	GameData.score=0
	GameData.lives=3
	GameData.game_over=false

	get_tree().change_scene_to_file("res://Breakout/breakout.tscn")
	
func start_game():
	$TitolJoc.visible = false
	$StartButton.visible = false
	ball = get_parent().get_node("CharacterBody2D-Pilota")
	if GameData.game_started != true:
		GameData.boto_start_amagat = true
		ball.start_ball()
		GameData.game_started = true
