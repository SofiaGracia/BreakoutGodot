extends CharacterBody2D

const SPEED = 300.0

func _ready():
	print("Estic en _ready")

func _physics_process(delta: float) -> void:
		# Si no toquem res, la velocitat es 0
		# velocity 

	velocity.x=0
	# Es llança cada vegada que s'actualitzen
	# les fisiques (de normal 60 vegades per segon)
	if Input.is_action_pressed("move_left"):
		velocity.x = -1
	elif Input.is_action_pressed("move_right"):
		velocity.x = 1

	# Multipliquem la velocitat per speed, pe a que vaja 
	# mes rapid
	velocity.x *= SPEED

	# Aquest depen de delta, per ser independent del framerate

	move_and_collide(velocity * delta)
