extends HBoxContainer
@export var player: Node2D
@onready var gui = preload("res://scenes/UI/heart.tscn")
func _ready():
	maxCorazones(player.maxVida)
	player.cambioVida.connect(actualizarCor)
	actualizarCor(player.vidaActual)
func maxCorazones(max: int):
	for i in range(max):
		var corazon = gui.instantiate()
		add_child(corazon)

func actualizarCor(vidaActual: int):
	var corazones = get_children()
	print(vidaActual)
	for i in range(vidaActual):
		print(i)
		corazones[i].actualizar(true)
	for i in range(vidaActual, corazones.size()):
		print(i)
		corazones[i].actualizar(false)
