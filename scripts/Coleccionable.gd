extends Area2D
@export var itemRes: ItemInventario

func colec(inventary: inventario):
	inventary.insertar(itemRes, self)
	queue_free()
