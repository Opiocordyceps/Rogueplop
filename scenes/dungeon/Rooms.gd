extends Node2D
#--Las escenas que contienen las distintas salas que conforman los niveles son almacenadas en distintos arreglos de acuerdo a su funcionalidad--
#--Mientras mayor cantidad de salas, mayor variedad--
const SPAWN_ROOMS: Array = [preload("res://scenes/dungeon/rooms/SpawnRoom0.tscn"), preload("res://scenes/dungeon/rooms/SpawnRoom1.tscn")]
const INTERMEDIATE_ROOMS: Array = [preload("res://scenes/dungeon/rooms/room_0.tscn"), preload("res://scenes/dungeon/rooms/room_1.tscn"), preload("res://scenes/dungeon/rooms/room_3.tscn"), preload("res://scenes/dungeon/rooms/room_4.tscn")]
const SPECIAL_ROOMS: Array = [preload("res://scenes/dungeon/rooms/room_0.tscn")]
const END_ROOMS: Array = [preload("res://scenes/dungeon/rooms/EndRoom0.tscn")]
const SLIME_BOSS_SCENE: PackedScene = preload("res://scenes/dungeon/rooms/EndRoom0.tscn")

const TILE_SIZE: int = 16
const FLOOR_TILE_CORD: Vector2i = Vector2i(3,1)
const RIGHT_WALL_TILE_INDEX: Vector2i = Vector2i(3,5)
const LEFT_WALL_TILE_INDEX: Vector2i = Vector2i(4,5)

@export var num_levels: int = 5

@onready var player: CharacterBody2D = get_parent().get_node("player")

#--Funcion que se inicializa al entrar a la escena, recupera datos de un script global para determinar la cantidad de salas a generar
func _ready() -> void:
	SavedData.num_floor += 1
	if SavedData.num_floor == 3:
		num_levels = 3
	_spawn_rooms()

#--Funcion De Generacion Procedural De Niveles--
func _spawn_rooms() -> void:
	var previous_room: Node2D
	var special_room_spawned: bool = false
#--Ciclo For para llamar e instanciar las distintas escenas, las cuales son llamadas al azar--
	for i in num_levels:
		var room: Node2D
#-------Primer Ciclo, se instancia la primera sala y el jugador en posicion--
		if i == 0:
			room = SPAWN_ROOMS[randi() % SPAWN_ROOMS.size()].instantiate()
			player.position = room.get_node("PlayerSpawnPos").position
		else:
#-----------Ultimo Ciclo, el cuarto final es instanciado
			if i == num_levels - 1:
				room = END_ROOMS[randi() % END_ROOMS.size()].instantiate()
			else:
#---------------Penultimo Ciclo, enfrentamiento especial (sin implementar)---
				if SavedData.num_floor == 3:
					room = SLIME_BOSS_SCENE.instantiate()
				else:
#-------------------Caso especial 
					if (randi() % 3 == 0 and not special_room_spawned) or (i == num_levels - 2 and not special_room_spawned):
						room = SPECIAL_ROOMS[randi() % SPECIAL_ROOMS.size()].instantiate()
						special_room_spawned = true
#-------------------En el resto de los casos se instancia una sala intermediaria
					else:
						room = INTERMEDIATE_ROOMS[randi() % INTERMEDIATE_ROOMS.size()].instantiate()
#-----------Se obtienen ciertos indices para conectar las salas entre si
			var previous_room_tilemap: TileMap = previous_room.get_node("TileMap")
			var previous_room_door: StaticBody2D = previous_room.get_node("Doors/Door")
#-----------Segundo Ciclo For, se conectan las salas con los Tiles correspondientes al piso y paredes para formar un pasillo
			var exit_tile_pos: Vector2i = previous_room_tilemap.local_to_map(previous_room_door.position)  + (Vector2i.UP * 2)
			var corridor_height: int = (randi() % 5) + 2
			for y in corridor_height:
				previous_room_tilemap.set_cell(0, exit_tile_pos + Vector2i(-2, -y), 0, LEFT_WALL_TILE_INDEX)
				previous_room_tilemap.set_cell(0, exit_tile_pos + Vector2i(-1, -y), 0, FLOOR_TILE_CORD)
				previous_room_tilemap.set_cell(0, exit_tile_pos + Vector2i(0, -y), 0, FLOOR_TILE_CORD)
				previous_room_tilemap.set_cell(0, exit_tile_pos + Vector2i(1, -y), 0, RIGHT_WALL_TILE_INDEX)

			var room_tilemap: TileMap = room.get_node("TileMap")
			room.position = previous_room_door.global_position + Vector2.UP * room_tilemap.get_used_rect().size.y * TILE_SIZE + Vector2.UP * (1 + corridor_height) * TILE_SIZE + Vector2.LEFT * room_tilemap.local_to_map(room.get_node("Entrance/Marker2D2").position).x * TILE_SIZE
#-------Se añade un nodo hijo y se almacena el valor de la sala ya recorrida
			room.position = previous_room_door.global_position + (Vector2.UP * room_tilemap.get_used_rect().size.y * TILE_SIZE) + (Vector2.UP * (corridor_height + 1) * TILE_SIZE) + (Vector2.LEFT * room_tilemap.local_to_map(room.get_node("Entrance/Marker2D2").position).x * TILE_SIZE)
		add_child(room)
		previous_room = room
