extends CharacterBody2D

const SPEED = 300.0

func _ready():
	print("Estic en _ready")

func _physics_process(delta: float) -> void:
	velocity = Vector2.ZERO
	# Valors del joystick
	# obtenim la intensitat del moviment cap a la dreta i cap a l'esquerra respectivament.
	var input_axis = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	# Mou el jugador
	if GameData.game_over != true:
		velocity.x = input_axis * SPEED
		move_and_collide(velocity * delta)
	
# Funcions per al moviment del jugador
func move_left():
	velocity.x = -1

func move_right():
	velocity.x = 1
