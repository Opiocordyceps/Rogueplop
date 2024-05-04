extends Panel
@onready var sprite = $Sprite2D

func actualizar(relleno: bool):
	if relleno == true:
		sprite.frame = 5
	else:
		sprite.frame = 0
