enum MINESWEEPER_TILE_STATE
{
	NOT_CLICKED = 1,
	FLAGGED = 2,
	QUESTIONED = 4,
	CLICKED = 8,
	BOMB = 16,
	BOMB_CLICKED = 32,
}

enum MINESWEEPER_GAME_END_TYPE
{
	NONE = 0,
	GAMEWIN = 1,
	GAMEOVER = 2,
}

bombs_to_make = 10
grid_width = 10
grid_height = 10

exitit = true
init = false
alarm[0] = 1

function _msw_create_bombs(ban_x, ban_y)
{
	randomize()

	var troll = bombs_to_make >= grid_width * grid_height
	var bombs_made = 0
	var bombs_max = grid_width * grid_height

	repeat(bombs_to_make)
	{
		if bombs_max <= bombs_made
			break;
		randomize()
		var _x = irandom(grid_width - 1)
		var _y = irandom(grid_height - 1)
		if (grid[# _x, _y].state & MINESWEEPER_TILE_STATE.BOMB)
		|| ((_x == ban_x && _y == ban_y) && !troll)
			while (grid[# _x, _y].state & MINESWEEPER_TILE_STATE.BOMB) 
			|| ((_x == ban_x && _y == ban_y) && !troll)
			{
				_x = irandom(grid_width - 1)
				_y = irandom(grid_height - 1)
				randomize()
			}
		grid[# _x, _y].state |= MINESWEEPER_TILE_STATE.BOMB
		bombs_made++
	}
}

function _msw_click_spot(grid_x, grid_y, loop = false)
{
	var grid_place = grid[# grid_x, grid_y] 
	
	if grid_place.state & MINESWEEPER_TILE_STATE.CLICKED
	|| grid_place.state & MINESWEEPER_TILE_STATE.BOMB
	|| grid_place.state & MINESWEEPER_TILE_STATE.QUESTIONED
	|| grid_place.state & MINESWEEPER_TILE_STATE.FLAGGED
		return;

	var _number = 0
	
	// this handles the number generation and the empty space loop thing
	grid_place.state ^= MINESWEEPER_TILE_STATE.NOT_CLICKED
	grid_place.state |= MINESWEEPER_TILE_STATE.CLICKED
	squares_clicked++;
	if !loop
		face_timer = 0.125
	
	for (var tile_check_around_id = 0; tile_check_around_id < 8; tile_check_around_id++)
	{// i hate this so much
		var new_pos_x = grid_x
		var new_pos_y = grid_y
		switch (tile_check_around_id)
		{
			default: new_pos_x -= 1; new_pos_y -= 1; break;
			case 1: new_pos_x -= 1; break;
			case 2: new_pos_x -= 1; new_pos_y += 1; break;
			case 3: new_pos_y += 1; break;
			case 4: new_pos_x += 1; new_pos_y += 1; break;
			case 5: new_pos_x += 1; break;
			case 6: new_pos_x += 1; new_pos_y -= 1; break;
			case 7: new_pos_y -= 1; break;
		}
		
		if new_pos_x < 0 || new_pos_x > grid_width - 1
		|| new_pos_y < 0 || new_pos_y > grid_height - 1
			continue; // useless, it's out of the grid
		var tile = grid[# new_pos_x, new_pos_y]
		
		if tile.state & MINESWEEPER_TILE_STATE.BOMB
			_number++
		
		grid[# new_pos_x, new_pos_y] = tile
	}
	if _number < 1
		for (var tile_check_around_id = 0; tile_check_around_id < 8; tile_check_around_id++)
		{// i hate this so much
			var new_pos_x = grid_x
			var new_pos_y = grid_y
			switch (tile_check_around_id)
			{
				default: new_pos_x -= 1; new_pos_y -= 1; break;
				case 1: new_pos_x -= 1; break;
				case 2: new_pos_x -= 1; new_pos_y += 1; break;
				case 3: new_pos_y += 1; break;
				case 4: new_pos_x += 1; new_pos_y += 1; break;
				case 5: new_pos_x += 1; break;
				case 6: new_pos_x += 1; new_pos_y -= 1; break;
				case 7: new_pos_y -= 1; break;
			}
		
			if new_pos_x < 0 || new_pos_x > grid_width - 1
			|| new_pos_y < 0 || new_pos_y > grid_height - 1
				continue; // useless, it's out of the grid
				
			_msw_click_spot(new_pos_x, new_pos_y, true)
		}
	grid_place.number = _number
	
	grid[# grid_x, grid_y]  = grid_place
}

function _msw_calc_grid_pos_and_if_in_grid()
{
	var ret_data = [[0, 0], false]
	
	var msx = device_mouse_x_to_gui(0) - grid_draw_tile_x
	var msy = device_mouse_y_to_gui(0) - grid_draw_tile_y

	if msx >= 0 && msx <= grid_width * 16 && msy >= 0 && msy <= grid_height * 16
		ret_data[1] = true
		
	if ret_data[1]
	{
		ret_data[0][0] = floor(msx / 16)
		ret_data[0][1] = floor(msy / 16)
	}
	return ret_data
}

function _msw_draw_grey_shaded_rect(x1,y1,x2,y2,size =3,inverse = false)
{
	var col1 = make_color_rgb(123, 123, 123)
	var col2 = c_white
	
	x1 = x1 - size
	y1 = y1 - size
	x2 = x2 + size
	y2 = y2 + size
	
	draw_set_color(inverse ? col2 : col1)
	draw_rectangle(x1 - size, y1 - size, x1 + size, y2 + size, false)
	draw_rectangle(x1 - size, y1 - size, x2 + size, y1 + size, false)
	
	
	draw_set_color(inverse ? col1 : col2)
	draw_rectangle(x1 - size, y2 - size, x2 + size, y2 + size, false)
	draw_rectangle(x2 - size, y1 - size, x2 + size, y2 + size, false)
	
	draw_set_color(c_white)
}

function _msw_string_number(number)
{
	var str = string(number)
	var len = 1 + (number > 9) + (number > 99)
	
	if len < 3
	{
		if len == 1
			str = "0" + str
		str = "0" + str
	}
	
	return str
}