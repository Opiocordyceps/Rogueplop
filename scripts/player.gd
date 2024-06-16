extends CharacterBody2D
signal cambioVida
const SPEED = 200.0
var maxVida = 5
var dañado: bool = false
@onready var vidaActual: int = maxVida
@onready var animation = $AnimatedSprite2D
@onready var espada = $espada
@onready var estoque = $estoque
@onready var atack = $Ataque
@onready var efectos = $efectos
@onready var hurtBox = $hurtBox
@onready var timer = $Timer
@export var inventory: inventario
var fuerzaEmpuje: int = 1000
var colisiones = []
var ultimaDireccion: String = "Down"

func _ready():
	espada.visible = false

func _physics_process(delta):
	##Consigue las inputs de cualquier direccion
	var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	##da vuelta al jugador en base a la direccion
	ataque()	
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
	#activa ciertas animaciones
	if direction.x == 0 && direction.y == 0:
		animation.play("idle")
	else:
		animation.play("run")
	velocity = direction * SPEED
	move_and_slide()
	if !dañado:
		for area in hurtBox.get_overlapping_areas():
			if area.name == "hitBox":
				dañadoPorEnemigo(area)
			if area.name == "Potion":
				pocionDeVida(area)

func ataque():
	if !inventory.items[0]: return
	elif Input.is_action_just_pressed("space"):
		if inventory.items[0].type == "sword":
			espada.activar()
			atack.play("attack" +  ultimaDireccion)
			await atack.animation_finished
			espada.desactivar()
		if inventory.items[0].type == "estoque":
			estoque.activar()
			atack.play("thrust" +  ultimaDireccion)
			await atack.animation_finished
			estoque.desactivar()

func pocionDeVida(area):
	if vidaActual<5:
		vidaActual += 1
		cambioVida.emit(vidaActual)

func dañadoPorEnemigo(area):
	vidaActual -= 1
	if vidaActual <0:
		vidaActual = maxVida
	cambioVida.emit(vidaActual)
	dañado = true
	empuje(area.get_parent().velocity)
	efectos.play("hurtBlink")
	timer.start()
	await timer.timeout
	efectos.play("RESET")
	dañado = false

func _on_hurt_box_area_entered(area):
	if area.has_method("colec"):
		area.colec(inventory)
		
func empuje(velocidadEnemigo: Vector2):
	var direccionEmpuje = (velocidadEnemigo - velocity).normalized() * fuerzaEmpuje
	velocity = direccionEmpuje
	move_and_slide()


func _on_hurt_box_area_exited(area):pass
	
