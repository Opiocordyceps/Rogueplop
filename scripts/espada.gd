extends "res://scripts/Coleccionable.gd"

@onready var animacion = $AnimationPlayer

func _ready():
	animacion.play("idle_sword")
	
func colec():
	super.colec()
