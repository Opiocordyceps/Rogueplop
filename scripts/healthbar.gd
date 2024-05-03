extends ProgressBar

@export var player: Node2D

func _ready():
	player.cambioVida.connect(cambioBarra)
	cambioBarra()

func cambioBarra():
	value = player.vidaActual * 100 / player.maxVida
