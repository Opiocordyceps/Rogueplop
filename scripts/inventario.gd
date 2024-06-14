extends Control

@onready var inventory: inventario = preload("res://scenes/UI/InventarioJugador.tres")
@onready var item: Panel = $inventario

func _ready():
	inventory.actualizado.connect(actualizar)
	actualizar()


func actualizar():
	item.actualizar(inventory.items[0])
