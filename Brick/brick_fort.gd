extends CharacterBody2D

var es_roig = true

func _ready():
	# Fem us dels grups com si ferem us d'etiquetes en Unity
	self.add_to_group("bricks")

func destroy(valor):
	
	if es_roig == true:
		$Sprite2D.texture = ResourceLoader.load("res://assets/brick.png")
		es_roig = false
	else:
	
		# Destruim l'objecte
		GameData.score+=(100*valor)
	
		# Creem un Tween amb 'create_tween', per fer una animació
		$CollisionShape2D.disabled = true  # Desactivem la col·lisió per evitar nous impactes mentre desapareix
	
		var tween = create_tween()
		# Esvaïm la transparència del Sprite2D (modulate.a)
		tween.tween_property($Sprite2D, "modulate:a", 0.0, 0.5)
	
		# Quan l'animació acaba, eliminem el bloc i comprovem si queden més blocs
		tween.finished.connect(func():
			queue_free()
			LevelManager.comprova_nombre_bricks()
			)
