extends CharacterBody2D

signal muerto
@onready var speed = 50
var vidaMaxima = 5
var fuerzaEmpuje: int = 1500
var movimiento: bool = true
var ultimaVelocidad: Vector2
var ultimaDireccion: String
@onready var vidaActual: int = vidaMaxima
#en orden de extraer el nodo player a patir de las propiedades del nodo slime
@export var player: Node2D
#exporta navigation agent en orden de encontrar la direccion del jugador
@onready var nav:= $NavigationAgent2D as NavigationAgent2D
@onready var animation = $AnimatedSprite2D
@onready var attack = $AnimationPlayer
@onready var timer = $Timer
@onready var hitBox = $hitBox

func _ready():
	speed = 50
	parent()
	attack.play("run")
	

func _physics_process(delta: float)->void:
	#ocupa una funcion de navegator agent en orden de actualizar la direccion
	var direction = to_local(nav.get_next_path_position()).normalized()
	if direction.x > 0:
		ultimaDireccion = "Right"
		animation.flip_h = false
	elif direction.x < 0:
		ultimaDireccion = "Left"
		animation.flip_h = true
	velocity = direction * speed
	move_and_slide()
	
##encuentra la locvalizacion del jugador
func makepath() -> void:
	nav.target_position = player.global_position

func parent():
	if !get_parent():return
	player = get_parent().get_parent().get_parent().get_parent().get_parent().get_node("player")



func _on_timer_timeout():
	makepath()


func _on_player_detector_area_entered(area):
	
	if area.name == "PlayerDetector":return
	movimiento = false
	ultimaVelocidad = velocity
	velocity.x = 0
	velocity.y = 0
	move_and_slide()
	velocity = ultimaVelocidad
	attack.play("dash" +  ultimaDireccion)
	timer.start()
	await timer.timeout
	movimiento = true
	speed = 100
	await attack.animation_finished
	speed = 50
	attack.play("run")


func _on_hurt_box_area_entered(area):
	if area.name == "hitBox": return
	if area.name == "hurtBox": return
	if area.get_parent().get_parent().name == "player":
		area.desactivar()
		vidaActual -= 1
		var direccionEmpuje = (area.get_parent().get_parent().velocity - velocity).normalized() * fuerzaEmpuje
		velocity = direccionEmpuje
		move_and_slide()
		if vidaActual == 0:
			muerto.emit("Elite")
			queue_free()
