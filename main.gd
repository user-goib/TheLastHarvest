
extends Node2D

const GRID_SIZE := 4
const TILE_SIZE := 80
const GRID_ORIGIN := Vector2(80, 100)

var selected_tile := Vector2i(-1, -1)


func _draw() -> void:
	for y in range(GRID_SIZE):
		for x in range(GRID_SIZE):
			var tile_position := GRID_ORIGIN + Vector2(x, y) * TILE_SIZE
			var tile_rect := Rect2(tile_position, Vector2(TILE_SIZE, TILE_SIZE))

			draw_rect(tile_rect, Color("#477a42"), true)
			draw_rect(tile_rect, Color("#294d2b"), false, 2.0)

	if selected_tile.x >= 0 and selected_tile.y >= 0:
		var selected_position := GRID_ORIGIN + Vector2(selected_tile) * TILE_SIZE
		var selected_rect := Rect2(selected_position, Vector2(TILE_SIZE, TILE_SIZE))
		draw_rect(selected_rect, Color("#f5d547"), false, 4.0)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			var mouse_position := get_global_mouse_position()
			var local_position := mouse_position - GRID_ORIGIN

			var tile_x := int(floor(local_position.x / TILE_SIZE))
			var tile_y := int(floor(local_position.y / TILE_SIZE))

			if tile_x >= 0 and tile_x < GRID_SIZE and tile_y >= 0 and tile_y < GRID_SIZE:
				selected_tile = Vector2i(tile_x, tile_y)
				queue_redraw()
