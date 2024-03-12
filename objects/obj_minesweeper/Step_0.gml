if !init
	return;
if !gameend
{
	if mouse_check_button_pressed(mb_left)
	{
		var data = _msw_calc_grid_pos_and_if_in_grid()
		if data[1]
		{
			var grid_place = grid[# data[0][0], data[0][1]] 
			if firstclick
			{
				if !(grid_place.state & MINESWEEPER_TILE_STATE.FLAGGED 
				|| grid_place.state & MINESWEEPER_TILE_STATE.QUESTIONED)
				{
					if grid_place.state & MINESWEEPER_TILE_STATE.BOMB
					{
						grid_place.state ^= MINESWEEPER_TILE_STATE.BOMB
						grid_place.state |= MINESWEEPER_TILE_STATE.BOMB_CLICKED
						gameend = MINESWEEPER_GAME_END_TYPE.GAMEOVER
					}
					else
					{
						_msw_click_spot(data[0][0], data[0][1])
						if (grid_width * grid_height - squares_clicked) == bombs_to_make
							gameend = MINESWEEPER_GAME_END_TYPE.GAMEWIN
					}
				}
			}
			else
			{
				_msw_create_bombs(data[0][0], data[0][1])
				// allow the troll
				if !(grid_place.state & MINESWEEPER_TILE_STATE.FLAGGED 
				|| grid_place.state & MINESWEEPER_TILE_STATE.QUESTIONED)
				{
					if grid_place.state & MINESWEEPER_TILE_STATE.BOMB
					{
						grid_place.state ^= MINESWEEPER_TILE_STATE.BOMB
						grid_place.state |= MINESWEEPER_TILE_STATE.BOMB_CLICKED
						gameend = MINESWEEPER_GAME_END_TYPE.GAMEOVER
					}
					else
					{
						_msw_click_spot(data[0][0], data[0][1])
						if (grid_width * grid_height - squares_clicked) == bombs_to_make
							gameend = MINESWEEPER_GAME_END_TYPE.GAMEWIN
					}
				}
				firstclick = true
			}
			grid[# data[0][0], data[0][1]] = grid_place
		}
	}
	if firstclick 
	{
		if mouse_check_button_pressed(mb_right) 
		{
			var data = _msw_calc_grid_pos_and_if_in_grid()
			if data[1]
			{
				var grid_place = grid[# data[0][0], data[0][1]]
				if !(grid_place.state & MINESWEEPER_TILE_STATE.CLICKED)
				{
					if grid_place.state & MINESWEEPER_TILE_STATE.FLAGGED
					{
						if grid_place.state & MINESWEEPER_TILE_STATE.QUESTIONED
							grid_place.state ^= MINESWEEPER_TILE_STATE.QUESTIONED
						if grid_place.state & MINESWEEPER_TILE_STATE.FLAGGED
						{
							grid_place.state ^= MINESWEEPER_TILE_STATE.FLAGGED
							bombs_left_to_draw++
						}
					}
					else if bombs_left_to_draw > 0
					{
						grid_place.state |= MINESWEEPER_TILE_STATE.FLAGGED
						bombs_left_to_draw--;
						if grid_place.state & MINESWEEPER_TILE_STATE.QUESTIONED	
							grid_place.state ^= MINESWEEPER_TILE_STATE.QUESTIONED
					}
				}
				grid[# data[0][0], data[0][1]] = grid_place
			}
		}
		if mouse_check_button_pressed(mb_middle)
		{
			var data = _msw_calc_grid_pos_and_if_in_grid()
			if data[1]
			{
				var grid_place = grid[# data[0][0], data[0][1]]
				if !(grid_place.state & MINESWEEPER_TILE_STATE.CLICKED)
				{
					if grid_place.state & MINESWEEPER_TILE_STATE.QUESTIONED
					{
						if grid_place.state & MINESWEEPER_TILE_STATE.QUESTIONED
							grid_place.state ^= MINESWEEPER_TILE_STATE.QUESTIONED
						if grid_place.state & MINESWEEPER_TILE_STATE.FLAGGED
						{
							grid_place.state ^= MINESWEEPER_TILE_STATE.FLAGGED
							bombs_left_to_draw++
						}
					}
					else
					{
						grid_place.state |= MINESWEEPER_TILE_STATE.QUESTIONED
						if grid_place.state & MINESWEEPER_TILE_STATE.FLAGGED
						{
							grid_place.state ^= MINESWEEPER_TILE_STATE.FLAGGED
							bombs_left_to_draw++					
						}
					}
				}
				grid[# data[0][0], data[0][1]] = grid_place
			}
		}
	}
	if firstclick && seconds_passed < 999
	{
		seconds_passed += 1 / 60
	}
}
if mouse_check_button_pressed(mb_left)
{
	var msx = device_mouse_x_to_gui(0) - (grid_draw_x + floor(grid_draw_w / 2) - 12)
	var msy = device_mouse_y_to_gui(0) - (grid_draw_y - 34)
	
	if msx >= 0 && msy >= 0
	&& msx <= 24 && msy <= 24
		face_pressed = true
}
if face_pressed || keyboard_check_pressed(ord("R"))
{
	if mouse_check_button_released(mb_left) || keyboard_check_pressed(ord("R"))
	{
		ds_grid_destroy(grid)
		event_user(0)
		exit;
	}
}
/*if keyboard_check_pressed(ord("Y"))
{
	exitit = false
	with instance_create(0,0,obj_minesweeper)
	{
		grid_width = get_integer("Grid width?")
	}
	instance_destroy()
}*/