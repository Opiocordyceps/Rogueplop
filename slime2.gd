extends CharacterBody2D

const speed = 50
#en orden de extraer el nodo player a patir de las propiedades del nodo slime
@export var player: Node2D
#exporta navigation agent en orden de encontrar la direccion del jugador
@onready var nav:= $NavigationAgent2D as NavigationAgent2D

func _physics_process(delta: float)->void:
	#ocupa una funcion de navegator agent en orden de actualizar la direccion
	var direction = to_local(nav.get_next_path_position()).normalized()
	velocity = direction * speed
	move_and_slide()
	
##encuentra la locvalizacion del jugador
func makepath() -> void:
	nav.target_position = player.global_position

##repite la funcion makepath
func _on_timer_timeout():
	makepath()
