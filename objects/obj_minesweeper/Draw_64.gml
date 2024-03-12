if !init
	return;
draw_set_color(make_color_rgb(189, 189, 189))

draw_rectangle(grid_draw_x - 10, grid_draw_y - 50, 
grid_draw_x + 10 + grid_draw_w, grid_draw_y + 10 + grid_draw_h, false)

_msw_draw_grey_shaded_rect(grid_draw_x - 11, grid_draw_y - 50,
grid_draw_x + grid_draw_w + 10, grid_draw_y + grid_draw_h + 10, 2, true)

draw_set_font(global.font_small)

// im not doing collisions in step im too lazy man
var msx = device_mouse_x_to_gui(0) - (grid_draw_x + grid_draw_w - 3)
var msy = device_mouse_y_to_gui(0) - (grid_draw_y - 49)

var skip_this = keyboard_check_pressed(vk_escape)
if (msx >= 0 && msy >= 0 
&& msx <= 12 && msy <= 12) || skip_this
{
	draw_set_color(c_ltgrey)
	if mouse_check_button_pressed(mb_left) || skip_this
	{
		instance_destroy()
		exit;
	}
}

draw_set_halign(fa_center)
draw_text(grid_draw_x + grid_draw_w + 3, grid_draw_y - 53, "x")

draw_set_color(c_white)
draw_set_font(number_font)


// silly face man
var face_index = 0
if face_timer > 0
{
	face_index = 2
	face_timer -= 1 / 60;
}
if gameend == MINESWEEPER_GAME_END_TYPE.GAMEWIN
{
	bombs_left_to_draw = 0
	face_index = 3
}
if gameend == MINESWEEPER_GAME_END_TYPE.GAMEOVER
	face_index = 4
if face_pressed
	face_index = 1

draw_set_color(c_white)
draw_set_align(fa_left)
draw_text(grid_draw_x + 2, grid_draw_y - 34, _msw_string_number(bombs_left_to_draw))
draw_set_halign(fa_right)
draw_text(grid_draw_x + grid_draw_w - 2, grid_draw_y - 34, _msw_string_number(floor(seconds_passed)))

draw_sprite(spr_minesweeper_face, face_index, grid_draw_x + floor(grid_draw_w / 2) - 12, grid_draw_y - 35)

for (var w = 0; w < grid_width; w++)
{
	for (var h = 0; h < grid_height; h++)
	{
		var grid_space = grid[# w, h]
		var spr_index = spr_minesweeper_tile
		var tile_index = 0
		
		if grid_space.state & MINESWEEPER_TILE_STATE.CLICKED
		{
			if grid_space.number > 0
			{
				spr_index = spr_minesweeper_tilenum
				tile_index = grid_space.number - 1
			}
			else
				tile_index = 1
		}
		if grid_space.state & MINESWEEPER_TILE_STATE.FLAGGED
			tile_index = 2
		else if grid_space.state & MINESWEEPER_TILE_STATE.QUESTIONED
			tile_index = 3
		if gameend == MINESWEEPER_GAME_END_TYPE.GAMEOVER 
		&& spr_index == spr_minesweeper_tile
		{
			if tile_index == 2
			{
				if !(grid_space.state & MINESWEEPER_TILE_STATE.BOMB)
					tile_index = 7
			}
			else if grid_space.state & MINESWEEPER_TILE_STATE.BOMB
				tile_index = 5
			else if grid_space.state & MINESWEEPER_TILE_STATE.BOMB_CLICKED
				tile_index = 6
		}
		
		draw_sprite(spr_index, tile_index, 16 * w + grid_draw_tile_x, 16 * h + grid_draw_tile_y)
	}
}


_msw_draw_grey_shaded_rect(grid_draw_x + 1, grid_draw_y - 35,
grid_draw_x + grid_draw_w - 2, grid_draw_y - 11, 0)

_msw_draw_grey_shaded_rect(grid_draw_x - 1, grid_draw_y - 1,
grid_draw_x + grid_draw_w, grid_draw_y + grid_draw_h, 1)
draw_set_halign(fa_left)
