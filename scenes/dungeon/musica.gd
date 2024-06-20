extends AudioStreamPlayer

@onready var music_controller = $".."
var menuMusic = preload("res://Music/Track_#1.wav")
var dungeonMusic:Array = [preload("res://Music/dungeon_theme_1.wav")]

func _physics_process(delta):
	music()

func music():
	if Global.type == "Menu":
		self.stream = menuMusic
		Global.type = ""
		self.play()
	if Global.type == "Dungeon":
		self.stream = dungeonMusic.pick_random()
		Global.type = ""
		self.play()
	
	
