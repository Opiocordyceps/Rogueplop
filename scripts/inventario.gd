extends Control

@onready var inventory: inventario = preload("res://scenes/UI/InventarioJugador.tres")
@onready var item: Panel = $inventario

func _ready():
	actualizar()


func actualizar():
	item.actualizar(inventory.item[0])
