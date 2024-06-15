extends Node2D

var weapon: Area2D

func _ready():
	if get_children().is_empty():return
	
	weapon = get_children()[0]

func activar():
	if !weapon:return
	visible = true
	weapon.activar()

func desactivar():
	if !weapon:return
	visible = false
	weapon.desactivar()
