extends CharacterBody2D

const speed = 50
@export var player: Node2D
@onready var nav:= $NavigationAgent2D as NavigationAgent2D

func _physics_process(delta: float)->void:
	var direction = to_local(nav.get_next_path_position()).normalized()
	velocity = direction * speed
	move_and_slide()
	
func makepath() -> void:
	nav.target_position = player.global_position


func _on_timer_timeout():
	makepath()
