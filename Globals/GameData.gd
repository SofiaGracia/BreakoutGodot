extends Node

#var lives = 3  # Vides inicials
#var score = 0  # Puntuació inicial
var current_level=0 # Nivell actual
# Definim les senyals
signal lives_changed(new_lives)
signal score_changed(new_score)
var game_over=false
# Definim les vides i els setters
var lives: int = 3:
	set(value):
		lives = value
		emit_signal("lives_changed", lives)

# Definim la puntuacio i els setters
var score: int = 0:
	set(value):
		score = value
		emit_signal("score_changed", score)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
