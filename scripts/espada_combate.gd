extends Area2D
@onready var cajaColision1 = $CollisionShape2D
@onready var cajaColision2 = $CollisionShape2D2

func activar():
	cajaColision1.disabled = false
	cajaColision2.disabled = false
func desactivar():
	cajaColision1.disabled = true
	cajaColision2.disabled = true
