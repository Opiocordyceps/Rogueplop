extends Node2D
class_name DungeonRoom

@export var boss_room: bool = false


#const SPAWN_EXPLOSION_SCENE: PackedScene = preload("res://Characters/Enemies/SpawnExplosion.tscn")

@export var ENEMY_SCENES: Array = [preload("res://scenes/entities/enemies/Slime2.tscn"),preload("res://scenes/entities/enemies/goblin.tscn")]

var num_enemies: int
var parent: Node2D

@onready var tilemap: TileMap = get_node("TileMap2")
@onready var entrance: Node2D = get_node("Entrance")
@onready var door_container: Node2D = get_node("Doors")
@onready var enemy_positions_container: Node2D = get_node("EnemyPositions")
@onready var player_detector: Area2D = get_node("PlayerDetector")



func _ready() -> void:
	num_enemies = enemy_positions_container.get_child_count()
func _on_enemy_killed() -> void:
	num_enemies -= 1
	if num_enemies == 0:
		_open_doors()


func _open_doors() -> void:
	for door in door_container.get_children():
		door.open()


func _close_entrance() -> void:
	for door in door_container.get_children():
		door.close()
#func _close_entrance() -> void:
	#for entry_position in entrance.get_children():
		#print(tilemap.local_to_map(entry_position.position))
		#tilemap.set_cell(0, tilemap.local_to_map(entry_position.position), 1, Vector2i.ZERO)
		#tilemap.set_cell(0, tilemap.local_to_map(entry_position.position) + Vector2i.DOWN, 2, Vector2i.ZERO)
#
func _spawn_enemies() -> void:
	for enemy_position in enemy_positions_container.get_children():
		var enemy = ENEMY_SCENES.pick_random().instantiate()
		
		#if boss_room:
			#enemy = ENEMY_SCENES.SLIME_BOSS.instantiate()
			#num_enemies = 15
		#else:
			#if randi() % 2 == 0:
				#enemy = ENEMY_SCENES.FLYING_CREATURE.instantiate()
			#else:
				#enemy = ENEMY_SCENES.GOBLIN.instantiate()
		enemy_position.add_child(enemy)
		enemy.global_position = enemy_position.global_position
		enemy.muerto.connect(_on_enemy_killed)
#
		#var spawn_explosion: AnimatedSprite2D = SPAWN_EXPLOSION_SCENE.instantiate()
		#spawn_explosion.position = enemy_position.position
		#call_deferred("add_child", spawn_explosion)



func _on_player_detector_body_entered(body):
	player_detector.queue_free()
	if num_enemies > 0:
		_close_entrance()
		_spawn_enemies()
