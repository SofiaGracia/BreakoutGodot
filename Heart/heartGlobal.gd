# HeartManager.gd (Singleton o script global)
extends Node2D

var timer : Timer
static var COLLISION_MASK: int = 4

# Funció per inicialitzar el temporitzador i crear cors cada 15 segons
func _ready() -> void:
	# Crear un temporitzador per generar cors cada 15 segons
	timer = Timer.new()
	timer.wait_time = 15  # Espera de 15 segons
	timer.autostart = true  # Comença automàticament
	timer.one_shot = false  # Continua activant-se
	add_child(timer)  # Afegir el temporitzador com a fill del node actual

	# Connectar la senyal de "timeout" per instanciar un cor
	timer.connect("timeout", Callable(self, "_inst_cor"))

# Funció per generar una posició aleatòria dins de la pantalla
func dona_pos_random_cor() -> int:
	var numero_aleatori = randi_range(10, (get_viewport().size.x)-10)
	return numero_aleatori

# Funció per instanciar i afegir un cor a l'escena
func _inst_cor():
	# Crear un nou cor
	var ins_cor = preload("res://Heart/heart.tscn").instantiate()
	var pos_cor = dona_pos_random_cor()  # Obtenir una posició aleatòria
	ins_cor.position = Vector2(pos_cor, 0)  # Col·locar el cor en la posició generada
	ins_cor.collision_mask = COLLISION_MASK
	get_parent().add_child(ins_cor)  # Afegir el cor com a fill del node pare
