extends Panel
@onready var sprite = $Sprite2D

func actualizar(relleno: bool):
	if relleno == true:
		print("a")
		sprite.set_frame(5)
	else:
		print("b")
		sprite.set_frame(0)
