extends Node2D
var borders = Rect2(1,1,31,15)
@onready var tileMap = $TileMap
# Called when the node enters the scene tree for the first time.
func _ready():
	generate_level()
	pass # Replace with function body.
func generate_level():
	var walker = Walker.new(Vector2(15, 8), borders)
	var map = walker.walk(500)
	walker.queue_free()
	for location in map:
		tileMap.set_cells_terrain_connect(location, -1)
	tileMap.update_bitmask_region(borders.position, borders.end)
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass
