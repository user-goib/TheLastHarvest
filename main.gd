
extends Node2D

const GRID_SIZE := 4
const TILE_SIZE := 80
const GRID_ORIGIN := Vector2(80, 100)

var selected_tile := Vector2i(-1, -1)
var cleared_tiles: Array[Vector2i] = []
var plantation_tiles: Array[Vector2i] = []


func _draw() -> void:
	for y in range(GRID_SIZE):
		for x in range(GRID_SIZE):
			var tile_position := GRID_ORIGIN + Vector2(x, y) * TILE_SIZE
			var tile_rect := Rect2(tile_position, Vector2(TILE_SIZE, TILE_SIZE))

			var tile := Vector2i(x, y)
			var tile_color := Color("#477a42")
			var border_color := Color("#294d2b")

			if tile in cleared_tiles:
				tile_color = Color("#9b7653")
				border_color = Color("#705137")

			if tile in plantation_tiles:
				tile_color = Color("#b4a65a")
				border_color = Color("#71652e")

			draw_rect(tile_rect, tile_color, true)
			draw_rect(tile_rect, border_color, false, 2.0)

	if selected_tile.x >= 0 and selected_tile.y >= 0:
		var selected_position := GRID_ORIGIN + Vector2(selected_tile) * TILE_SIZE
		var selected_rect := Rect2(selected_position, Vector2(TILE_SIZE, TILE_SIZE))
		draw_rect(selected_rect, Color("#f5d547"), false, 4.0)

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.keycode == KEY_SPACE and event.pressed and not event.echo:
			if selected_tile.x >= 0 and selected_tile.y >= 0:
				if selected_tile not in cleared_tiles:
					cleared_tiles.append(selected_tile)
					queue_redraw()
	if event is InputEventKey:
		if event.keycode == KEY_P and event.pressed and not event.echo:
			if selected_tile in cleared_tiles:
				if selected_tile not in plantation_tiles:
					plantation_tiles.append(selected_tile)
					queue_redraw()
							
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			var mouse_position := get_global_mouse_position()
			var local_position := mouse_position - GRID_ORIGIN

			var tile_x := int(floor(local_position.x / TILE_SIZE))
			var tile_y := int(floor(local_position.y / TILE_SIZE))

			if tile_x >= 0 and tile_x < GRID_SIZE and tile_y >= 0 and tile_y < GRID_SIZE:
				selected_tile = Vector2i(tile_x, tile_y)
				queue_redraw()
