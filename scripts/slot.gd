extends Panel

@onready var fondoSprite: Sprite2D = $fondo
@onready var itemSprite: Sprite2D = $CenterContainer/Panel/item

func actualizar(item: ItemInventario):
	if !item:
		itemSprite.visible = false
	else:
		itemSprite.visible = true
		itemSprite.texture = item.textura
