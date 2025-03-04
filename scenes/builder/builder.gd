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

var plane := Plane(Vector3.UP, Vector3.ZERO)

var cursor_to_world_raycaster : CursorToPerspectiveCameraRaycaster

func _initialize_cursor_to_world_raycaster() -> void:
	if cursor != null and camera != null:
		cursor_to_world_raycaster =\
			CursorToPerspectiveCameraRaycaster.new(camera, plane, cursor)
	else:
		cursor_to_world_raycaster = null

# Tile map where buildings will be places
@export var builder_gridmap: BuilderGridmap

# In-Game 3D cursor to preview buildinds to be placed in city
@export var selector: Node3D

func _ready() -> void:
	if selector == null : _set_default_selector()

func _set_default_selector() -> void:
	selector = $GroundTileSelector

func _process(delta) -> void:
	_move_selector_to_cursor_position()

func _move_selector_to_cursor_position() -> void:
	var cursor_position_in_world = cursor_to_world_raycaster.screen_cursor_position_in_world()

	if cursor_position_in_world == null: return

	selector.position = builder_gridmap.world_position_to_tile_center(cursor_position_in_world) * Vector3(1, 0, 1)
