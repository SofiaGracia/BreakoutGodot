extends CharacterBody2D

const SPEED = 100.0
const GRAVITY = 100.0  # Simulació de la gravetat
const JUMP_VELOCITY = -400.0
var velocitat_cor = Vector2(0,50)

func _ready() -> void:
	self.add_to_group("hearts")
		
func _physics_process(delta: float) -> void:
	# Afegir la gravetat al moviment del cor (incrementar la velocitat en Y)
	velocity.y += GRAVITY * delta  # La gravetat augmenta la velocitat vertical amb el temps

	# Moure el cor a la posició
	position += velocity * delta  # Moviment del cor en funció de la velocitat
	
	move_and_slide()
	
func destroy():
	var tween = create_tween()
	tween.tween_property($Sprite2D, "modulate:a", 0.0, 0.3)
	tween.finished.connect(func():
		queue_free()
		)
	
