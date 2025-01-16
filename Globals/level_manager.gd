extends Node

# Definicio dels nivells
var levels = [
	"res://Breakout/breakout.tscn",
	"res://Breakout/breakout_level2.tscn"]
# Called when the node enters the scene tree for the first time.
# Funcio per canviar de pantalla
func load_next_level():
	# Pugem de nivell
	GameData.current_level += 1
	if GameData.current_level>=levels.size():
		GameData.current_level=0; # Joc infinit, quan arribem al final de les pantalles, tornem a començar

	# Carreguem el nivell
	get_tree().change_scene_to_file(levels[GameData.current_level])
	
func _pausa(ms):
	# Funcio auxiliar que crea una pausa 
	# fent us d'un temporitzador
	var timer = Timer.new() # Creem un temporitzador (timer)
	timer.wait_time = ms    # Establim el temps d'espera (wait_time)
	timer.one_shot = true   # Assegurem que siga d'us unic
	add_child(timer)        # Afegim el temporitzador a l'escena
	timer.start()           # Iniciem el temporitzador
	await timer.timeout     # Esperem que el temporitzador acabe


func comprova_nombre_bricks():
	# Fem una pausa de ms, per a que la comprovacio es realitze al proxim frame
	await _pausa(0)

	if get_tree().get_nodes_in_group("bricks").size() == 0:
		load_next_level()

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
