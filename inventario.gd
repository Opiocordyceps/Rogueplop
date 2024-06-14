extends Resource

class_name inventario

signal actualizado

@export var items: Array[ItemInventario]

func insertar(item:ItemInventario, coleccionable: Area2D):
	if(coleccionable.name != "Potion"):
		items[0] = item
		actualizado.emit()
