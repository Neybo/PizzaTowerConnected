/// @description reset
init = true
seconds_passed = 0
squares_clicked = 0 
bombs_left_to_draw = bombs_to_make 
grid = ds_grid_create(grid_width, grid_height)
gameend = MINESWEEPER_GAME_END_TYPE.NONE
firstclick = false

number_font = font_add_sprite_ext(spr_minesweeper_numfont, "1234567890-B", true, 0)

grid_draw_w = max(16 * grid_width, 160)
grid_draw_h = max(16 * grid_height, 80)

grid_draw_x = floor(480 - (grid_draw_w / 2))
grid_draw_y = floor(270 - (grid_draw_h / 2))

grid_draw_tile_x = 480 - (8 * grid_width)
grid_draw_tile_y = 270 - (8 * grid_height)

face_timer = 0
face_pressed = false

for (var w = 0; w < grid_width; w++)
{
	for (var h = 0; h < grid_height; h++)
	{
		grid[# w, h] = {
			state: MINESWEEPER_TILE_STATE.NOT_CLICKED,
			number: 0
		}
	}
}