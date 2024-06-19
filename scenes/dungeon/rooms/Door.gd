extends StaticBody2D

@onready var animation_player : AnimationPlayer = get_node("AnimationPlayer")

# Called when the node enters the scene tree for the first time.
func _ready():
	animation_player.play("default")
func open() ->void:
	animation_player.play("open")
func close() ->void:
	animation_player.play_backwards("open")


# Called every frame. 'delta' is the elapsed time since the previous frame.
