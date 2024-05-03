extends CharacterBody2D

const SPEED = 200.0
@onready var animation = $AnimatedSprite2D

func _physics_process(delta):
	##Consigue las inputs de cualquier direccion
	var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	##da vuelta al jugador en base a la direccion
	if direction.x > 0:
		animation.flip_h = false
	elif direction.x < 0:
		animation.flip_h = true
	#activa ciertas animaciones
	if direction.x == 0:
		animation.play("idle")
	else:
		animation.play("run")
	velocity = direction * SPEED
	move_and_slide()
