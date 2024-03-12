depth = 12;
if scr_depthcheck()
	depth += 100;
image_speed = 0;
autotile = false;

// auto tile and extend hitbox in remix
if FINAL_GAMEPLAY
{
	mask_index = spr_wall;
	event_perform(ev_alarm, 0);
}

var roomname = room_get_name(room), ladderspr = spr_ladder;
if string_endswith(string_letters(roomname), "FINAL")
	visible = false

// level specific ladders
if sprite_index == spr_ladder
{
	// factory
	if string_startswith(roomname, "oldfactory_")
		ladderspr = spr_ladder_factory;
	
	// sugary spire
	else if check_sugary()
		ladderspr = spr_ladderSP_rope;
	
	// level specific
	if FINAL_GAMEPLAY
	{
		// set the sprites
		if global.snickrematch
		{
			if string_endswith(string_letters(roomname), "medieval")
			{
				for (var i = 0; i < 20; ++i)
				{
					if string_startswith(roomname, "medieval_" + string(i))
					{
						if i <= 5
							ladderspr = spr_ladder_medieval_re;
						else
							ladderspr = spr_ladder_medieval2_re;
					}
				}
			}
			if string_endswith(string_letters(roomname), "ruin")
				ladderspr = spr_ladder_ruin_re
			if string_startswith(roomname, "dungeon_")
			{
				for (var i = 0; i < 20; ++i)
				{
					if string_startswith(roomname, "dungeon_" + string(i))
					{
						if i <= 6
							ladderspr = spr_ladder_dungeon1_re;
						else if i <= 8
							ladderspr = spr_ladder_dungeon2_re;
						else
							ladderspr = spr_ladder_dungeon3_re;
					}
				}
			}
			if string_endswith(string_letters(roomname), "secret")
				ladderspr = spr_ladder_secret_re
		}
		else
		{
			if string_startswith(roomname, "oldsewer_")
				ladderspr = spr_ladder_sewer
			if string_startswith(roomname, "oldfreezer_")
				ladderspr = spr_ladder_freezer
			if string_startswith(roomname, "oldmansion_")
			{
				for (var i = 0; i < 20; ++i)
				{
					if string_startswith(roomname, "oldmansion_" + string(i))
					{
						if i <= 8
							ladderspr = spr_ladder_mansion;
						else if i > 8
							ladderspr = spr_ladder_forest;
					}
				}
			}
			if string_startswith(roomname, "golf_")
			or string_startswith(roomname, "minigolf_")
				ladderspr = spr_ladder_golf

			if string_endswith(string_letters(roomname), "medieval")
				ladderspr = spr_ladder_medieval
			if string_endswith(string_letters(roomname), "chateau")
				ladderspr = spr_ladder_chateau
			if string_endswith(string_letters(roomname), "ruin")
				ladderspr = spr_ladder_ruin
			if string_startswith(roomname, "dungeon_")
			{
				for (var i = 0; i < 20; ++i)
				{
					if string_startswith(roomname, "dungeon_" + string(i))
					{
						if i <= 6
							ladderspr = spr_ladder_dungeon1;
						else if i <= 8
							ladderspr = spr_ladder_dungeon2;
						else
							ladderspr = spr_ladder_dungeon3;
					}
				}
			}
			if string_endswith(string_letters(roomname), "kungfu")
				ladderspr = spr_ladder_kungfu

			if string_startswith(string_letters(roomname), "entrance")
				ladderspr = spr_ladder_entrance

			if string_endswith(string_letters(roomname), "secret") && !check_sugary()
				ladderspr = spr_ladder_secret
			
			if string_endswith(string_letters(roomname), "shop")
				ladderspr = spr_ladder_eatery
		}
	}
	
	with obj_ladder
	{
		if object_index == obj_ladder
			sprite_index = ladderspr;
	}
}
