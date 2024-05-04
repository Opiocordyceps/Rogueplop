extends Control

@warning_ignore("unused_parameter")
func _process(delta):
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()
	if Input.is_action_just_pressed("space"):
		get_tree().change_scene_to_file("res://scenes/dungeon/dungeon.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
