extends AudioStreamPlayer

var slash: Array = [preload("res://sounds/07_human_atk_sword_1.wav"), preload("res://sounds/07_human_atk_sword_2.wav"), preload("res://sounds/07_human_atk_sword_3.wav")]

func _physics_process(delta):
	music()

func music():
	if Global.type == "Slash":
		self.stream = slash.pick_random()
		self.play()
		Global.type = ""
