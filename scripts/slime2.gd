extends CharacterBody2D

const speed = 50
var vidaMaxima = 3
var fuerzaEmpuje: int = 1500
@onready var vidaActual: int = vidaMaxima
#en orden de extraer el nodo player a patir de las propiedades del nodo slime
@export var player: Node2D
#exporta navigation agent en orden de encontrar la direccion del jugador
@onready var nav:= $NavigationAgent2D as NavigationAgent2D
@onready var animation = $AnimatedSprite2D


func _physics_process(delta: float)->void:
	#ocupa una funcion de navegator agent en orden de actualizar la direccion
	var direction = to_local(nav.get_next_path_position()).normalized()
	if direction.x > 0:
		animation.flip_h = false
	elif direction.x < 0:
		animation.flip_h = true
	velocity = direction * speed
	move_and_slide()
	
##encuentra la locvalizacion del jugador
func makepath() -> void:
	nav.target_position = player.global_position

#repite la funcion makepath
func _on_timer_timeout():
	makepath()


func _on_hurt_box_area_entered(area):
	if area == $hitBox: return
	area.desactivar()
	vidaActual -= 1
	var direccionEmpuje = (area.get_parent().get_parent().velocity - velocity).normalized() * fuerzaEmpuje
	velocity = direccionEmpuje
	move_and_slide()
	if vidaActual == 0:
		$hitBox.set_deferred("monitorable", false)	
		
		queue_free()
