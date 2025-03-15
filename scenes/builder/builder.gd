extends Node3D

class_name Builder

# Game Cursor -> Used for building the city
@export var cursor: Cursor :
	set (new_cursor):
		cursor = new_cursor
		_initialize_cursor_to_world_raycaster()

# Game Camera
@export var camera: Camera3D :
	set (new_camera):
		camera = new_camera
		_initialize_cursor_to_world_raycaster()

# Transforms player cursor 2D coordinates from
# screen into 3D coordinates of the game world
var cursor_to_world_raycaster : CursorToPerspectiveCameraRaycaster

var plane := Plane(Vector3.UP, Vector3.ZERO)

func _initialize_cursor_to_world_raycaster() -> void:
	if cursor != null and camera != null:
		cursor_to_world_raycaster =\
			CursorToPerspectiveCameraRaycaster.new(camera, plane, cursor)
	else:
		cursor_to_world_raycaster = null

@export var selector: Node3D :
	set (new_selector):
		selector = new_selector

# Tile map where buildings will be places
@export var builder_gridmap: BuilderGridmap

# TODO: remove this now we have the new selector class
func _ready() -> void:
	if selector == null : selector = $Selector

func _process(delta) -> void:
	_move_selector_to_cursor_position()

func _move_selector_to_cursor_position() -> void:
	var cursor_position_in_world = cursor_to_world_raycaster.screen_cursor_position_in_world()

	if cursor_position_in_world == null: return

	selector.position = builder_gridmap.world_position_to_tile_center(cursor_position_in_world) * Vector3(1, 0, 1)
