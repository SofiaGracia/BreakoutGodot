extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
# Mètode per actualitzar les vides
func pinta_vides(vides: int):
	# Itera sobre els fills (els cors/vides)
	for i in range(get_child_count()):
		var cor = get_child(i)  # Obté cada cor
		if i < vides:
			cor.visible = true  # Mostra els cors dins del rang de vides
		else:
			cor.visible = false  # Oculta els cors restants
