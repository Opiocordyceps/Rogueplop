extends Area2D
@onready var cajaColision1 = $HitBox1
@onready var cajaColision2 = $HitBox2

func activar():
	cajaColision1.disabled = false
	cajaColision2.disabled = false
func desactivar():
	cajaColision1.disabled = true
	cajaColision2.disabled = true
