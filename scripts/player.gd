extends CharacterBody2D
signal cambioVida
const SPEED = 200.0
var maxVida = 5
var dañado: bool = false
@onready var vidaActual: int = maxVida
@onready var animation = $AnimatedSprite2D
@onready var efectos = $efectos
@onready var hurtBox = $hurtBox
@onready var timer = $Timer
var fuerzaEmpuje: int = 1000
var colisiones = []

func _physics_process(delta):
	##Consigue las inputs de cualquier direccion
	var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	##da vuelta al jugador en base a la direccion
	if direction.x > 0:
		animation.flip_h = false
	elif direction.x < 0:
		animation.flip_h = true
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
		area.colec()
		
func empuje(velocidadEnemigo: Vector2):
	var direccionEmpuje = (velocidadEnemigo - velocity).normalized() * fuerzaEmpuje
	velocity = direccionEmpuje
	move_and_slide()


func _on_hurt_box_area_exited(area):pass
	
