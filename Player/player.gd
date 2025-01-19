extends CharacterBody2D

const SPEED = 300.0
var touch_x = null
var moviment = null

func _ready():
	print("Estic en _ready")

func _physics_process(delta: float) -> void:
	# No ens movem si el joc ha acabat
	if GameData.game_over:
		return
	
	velocity = Vector2.ZERO
	
	 # Comprovem si la posicio touch_x no es nul·la, 
	# per vore si s'esta movent el jugador amb la 
	# pantalla tactil o el ratoli
	if touch_x != null:
		#  Si es aixi, movem el jugador cap a la posicio touch_x
		moviment = (touch_x - global_position.x) * SPEED * delta
	else:
		# Si no s'esta utilitzant la pantalla tactil, comprovem el gamepad/teclat
		var input_axis = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
		# Mou el jugador
		moviment = input_axis * SPEED
	
	if GameData.game_over != true and GameData.game_started == true:
		velocity.x = moviment
		move_and_collide(velocity * delta)
	
# Funcions per al moviment del jugador
func move_left():
	velocity.x = -1

func move_right():
	velocity.x = 1
	
func _input(event: InputEvent) -> void:
	# Detectem si s'esta produint un tap o un clic en la pantalla
	if event is InputEventMouseButton:
		# print("S'ha detectat un event tap/click")
		# Comprovem si es tracta d'un clic o touch (inicial) en la pantalla
		if event.is_pressed():
			#print("El tap o clic es mante")
			# Si es aixi, ens guardem la posicio x d'on s'ha produit el toc
			touch_x = event.position.x # Guarda la posició X del toc
		else:
			# print("El tap o clic s'ha alliberat")
			touch_x = null  # Reseteja si es deixa de tocar
			
	# Si s'esta movent el ratoli o el dit per la pantalla, actualitzem la posicio X
	elif event is InputEventMouseMotion and touch_x != null:
		touch_x = event.position.x  # Actualitza la posició X del toc
