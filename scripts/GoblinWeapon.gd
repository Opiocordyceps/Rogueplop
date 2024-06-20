extends Node2D

@onready var weapon = get_children()[0]

func activar():
	if !weapon:return
	visible = true
	weapon.visible = true
	weapon.activar()

func desactivar():
	if !weapon:return
	weapon.visible = false
	visible = false
	weapon.desactivar()
