extends Node2D

var tile = preload("res://tile.tscn")

const dir = [Vector2.RIGHT, Vector2.LEFT, Vector2.UP, Vector2.DOWN]

var grid_size = 7
var grid_spread = 16
var grid_steps = 200
var grid = []

func _ready():
	randomize()
	create_level()

func create_level():
	var current_pix = Vector2(0,0)
	var current_pos = Vector2(0,0)
	
	var current_dir = Vector2.RIGHT
	var last_dir = current_dir * -1
	
	for i in range (0, grid_steps):
		var temp_dir = dir.duplicate()
		temp_dir.shuffle()
		var d = temp_dir.pop_front()
		
		while(abs(current_pos.x + d.x) > grid_size or abs(current_pos.y + d.y) > grid_size or d == last_dir * -1):
			temp_dir.shuffle()
			d = temp_dir.pop_front()
			
		current_pos += d
		current_pix += d*grid_spread
		last_dir = d
		
		var t = tile.instantiate()
		t.position = current_pix
		
		add_child(t)
		grid.append(t)
