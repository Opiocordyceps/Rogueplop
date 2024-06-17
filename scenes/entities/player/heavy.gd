extends Node2D

var weapon: Area2D
var item: ItemInventario
var weapons: Array
@export var inventory: inventario 

func _ready():
	weapons = get_children()
	for i in len(weapons):
		weapon = get_children()[i]
		desactivar()

func _physics_process(delta):
	arma()


func arma():
	if !inventory.items[0]: return
	item = inventory.items[0]
	if (item.name == "hammer"):
		weapon = get_children()[0]
	if (item.name == "claymore"):
		weapon = get_children()[1]
	if (item.name == "bible"):
		weapon = get_children()[2]

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
