extends StaticBody2D

@onready var animation_player : AnimatedSprite2D = get_node("AnimatedSprite2D")
# Called when the node enters the scene tree for the first time.
func open() ->void:
	animation_player.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
