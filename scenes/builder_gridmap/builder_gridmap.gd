extends GridMap

class_name BuilderGridmap

func tile_local_center() -> Vector3:
	return cell_size * 0.5

func world_position_to_tile_coordinates(position: Vector3) -> Vector3:
	return Vector3(
		round((position.x - tile_local_center().x) / cell_size.x),
		round((position.y - tile_local_center().y) / cell_size.y),
		round((position.z - tile_local_center().z) / cell_size.z)
	)

func tile_coordinates_to_world_position(tile_coordinates: Vector3) -> Vector3:
	return (tile_coordinates * cell_size) + tile_local_center()

func world_position_to_tile_center(position: Vector3) -> Vector3:
	return tile_coordinates_to_world_position(world_position_to_tile_coordinates(position))
