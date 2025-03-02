extends Node3D

# Given a 3D camera in perspective mode and a plane,
# infers the equivalent on-camera position of the mouse
# in the projected world-environment plane coordinates
class_name CursorToPerspectiveCameraRaycaster

var view_camera: Camera3D
var world_plane: Plane
var game_cursor: Cursor

func _init(new_view_camera: Camera3D, new_world_plane: Plane, new_game_cursor: Cursor) -> void:
	if new_view_camera.projection != Camera3D.PROJECTION_PERSPECTIVE:
		push_error("
			Attempted to instantiate a CursorToPerspectiveCameraRaycaster object
			with a Camera3D instance configured without a 'perspective' mode
			projection. This class only supports perspective cameras.
		")

	view_camera = new_view_camera
	world_plane = new_world_plane
	game_cursor = new_game_cursor

func screen_cursor_position_in_world() -> Vector3:
	return world_plane.intersects_ray(
		view_camera.project_ray_origin(game_cursor.screen_position()),
		view_camera.project_ray_normal(game_cursor.screen_position())
	)
