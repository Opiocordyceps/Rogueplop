extends Panel
@onready var sprite = $Sprite2D

func actualizar(relleno: bool):
	if relleno == true:
		print("a")
		sprite.frame = 5
	else:
		print("b")
		sprite.frame = 0
