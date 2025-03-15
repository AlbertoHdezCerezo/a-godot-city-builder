extends Node3D

# Represents the game cursor
class_name Cursor

func screen_position() -> Vector2:
	return get_viewport().get_mouse_position()
