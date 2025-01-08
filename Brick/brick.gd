extends CharacterBody2D

func _ready():
	# Fem us dels grups com si ferem us d'etiquetes en Unity
	self.add_to_group("bricks")

func destroy():
	# Destruim l'objecte
	queue_free()
