extends CharacterBody2D		# Script per controlar la pilota. Es un CharacterBody2D

var speed=400				# Velocitat inicial de la pilota

var sobre_jugador = false  # Estat inicial de la pilota
var jugador                # Referència al jugador
var objecte_col = null
var cont_bricks = 1
var cors_tocats = []
var n_jugador = null

func _ready():
	# Aquest metode s'invoca nomes una vegada, quan la pilota s'insereix a l'escena
	print("Estic passant per ací")
	n_jugador = get_parent().get_node("CharacterBody2D-Player")
	
func start_ball():
	set_ball_velocity()
	
func set_ball_velocity():
	
	# Posar ací la posicio
	position = n_jugador.global_position + Vector2(0, -30)
	
	if randi() % 2 ==0:
		velocity.x=1
	else:
		velocity.x=-1
		
	if randi() % 2 ==0:
		velocity.y=1
	else:
		velocity.y=-1

	velocity *= speed

func _physics_process(delta):
	
	# Nomes movem la pilota si es visible (self es la propia pilota)
	if not self.visible:
		return
	# A cada actualitzacio de les fisiques, desplacem la pilota
	# fins que trobe una col·lissio.
	# Quan troba una col·lissio, la funcio move_and_collide ens
	# torna un objecte de tipus KinematicCollision2D amb la informacio d'aquesta
	var info_colissio=move_and_collide(velocity*delta)

	if info_colissio:
		# Fem us del metode bounce del vector velocitat, proporcionant-li
		# la component normal de la col·lissio.
		# Aixo ens retorna un vector "reflex", es a dir, un "rebot" de la pilota.
		velocity=velocity.bounce(info_colissio.get_normal())
		
		# Nou: Amb get_collider sabem l'objecte amb que hem col·lissionat
		var ObjecteCollissionat=info_colissio.get_collider()
		
		# Comprovem si l'objecte amb què ha col·lissionat és un brick
		# Si és així, li enviarem la senyal `destroy` (realment, invocarem aquest mètode que hem creat)
		if ("bricks" in ObjecteCollissionat.get_groups()):
			
			if (objecte_col!= null and "bricks" in objecte_col.get_groups()):
				cont_bricks+=1
			else:
				cont_bricks = 1
			
			ObjecteCollissionat.destroy(cont_bricks)
			
		if ("hearts" in ObjecteCollissionat.get_groups()):
			if not cors_tocats.has(ObjecteCollissionat):
				print(GameData.lives)
				GameData.lives += 1
				var parent_node = get_parent()
				var control = parent_node.get_node("HUD/ControlVides")	
				control.pinta_vides(GameData.lives)
				cors_tocats.append(ObjecteCollissionat)
			#Ací vull pintar un nou cor en el cas de que el número de cors siga menor a 3
			ObjecteCollissionat.destroy()
			
		objecte_col = ObjecteCollissionat
		
	if (sobre_jugador and jugador) or (GameData.nivell_iniciat == true):
		# Seguim la pala
		position = n_jugador.global_position + Vector2(0, -30)
		return 

func reset_ball(node_jugador):
	jugador = node_jugador
	sobre_jugador=true
	velocity = Vector2.ZERO
	position = n_jugador.global_position + Vector2(0, -30)
	
func _input(event):
	if Input.is_action_pressed("throw_ball") and GameData.game_over != true and GameData.game_started == true and sobre_jugador == true:
		GameData.nivell_iniciat = false
		sobre_jugador = false
		velocity = Vector2(n_jugador.velocity.normalized().x, -1).normalized() * 400  # Llança cap amunt
	
