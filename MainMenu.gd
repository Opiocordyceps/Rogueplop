extends Control


func _ready():
	Global.type = "Menu"

func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/dungeon/dungeon.tscn")


func _on_button_3_pressed():
	get_tree().quit()


func _on_button_2_pressed():
	get_tree().change_scene_to_file("res://scenes/UI/options.tscn")
