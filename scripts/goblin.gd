extends CharacterBody2D

signal muerto
const speed = 70
var vidaMaxima = 3
var fuerzaEmpuje: int = 1500
var ultimaDireccion: String
var ultimaVelocidad: Vector2
var movimiento: bool = true
var exited: bool = true
@onready var vidaActual: int = vidaMaxima
#en orden de extraer el nodo player a patir de las propiedades del nodo slime
@export var player: Node2D
#exporta navigation agent en orden de encontrar la direccion del jugador
@onready var nav:= $NavigationAgent2D as NavigationAgent2D
@onready var animation = $AnimatedSprite2D
@onready var attack = $attack
@onready var weapon = $weapon


func _ready():
	parent()
	weapon.desactivar()

func _physics_process(delta: float)->void:
	if movimiento == true:
		animation.play("run")
		var direction = to_local(nav.get_next_path_position()).normalized()
		if direction.x > 0:
			ultimaDireccion = "Right"
			animation.flip_h = false
		elif direction.x < 0:
			ultimaDireccion = "Left"
			animation.flip_h = true
		if direction.y > 0:
			ultimaDireccion = "Down"
		elif direction.y < 0:
			ultimaDireccion = "Up"
		velocity = direction * speed
		move_and_slide()
	
##encuentra la locvalizacion del jugador
func makepath() -> void:
	nav.target_position = player.global_position
	
func on_area():
	movimiento = false
	ultimaVelocidad = velocity
	velocity.x = 0
	velocity.y = 0
	move_and_slide()
	velocity = ultimaVelocidad
	animation.play("default")
	weapon.activar()
	attack.play("attack" +  ultimaDireccion)
	await attack.animation_finished
	weapon.desactivar()
	movimiento = true

func _on_timer_timeout():
	makepath()
	if exited == false:
		on_area()

func parent():
	if !get_parent():return
	player = get_parent().get_parent().get_parent().get_parent().get_parent().get_node("player")


func _on_hurt_box_area_entered(area):
	if area.name == "hitBox": return
	if area.name == "hurtBox": return
	if area.name == "playerDetector": return
	if area.get_parent().get_parent().name == "player":
		area.desactivar()
		vidaActual -= 1
		var direccionEmpuje = (area.get_parent().get_parent().velocity - velocity).normalized() * fuerzaEmpuje
		velocity = direccionEmpuje
		move_and_slide()
		if vidaActual == 0:
			muerto.emit("Normal")
			queue_free()


func _on_player_detector_area_entered(area):
	if area.name == "PlayerDetector":return
	exited = false
	on_area()


func _on_player_detector_area_exited(area):
	exited = true
