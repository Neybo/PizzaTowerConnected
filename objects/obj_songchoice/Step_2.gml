scr_getinput(true);

if !searching
{
	xoffset = lerp(xoffset, 0, 0.25);
	yoffset = lerp(yoffset, 0, 0.25);

	// change the palette
	if con == 1
		exit;

	if key_start or key_slap2
	{
		keyboard_clear(global.key_start);
		keyboard_clear(global.key_slap);
	
		scr_soundeffect(sfx_enemyprojectile);
		con = 1;
		t = 0;
		exit;
	}

	// song select
	if (key_up2 or (holdt == 0 && key_up))
	{
		scr_soundeffect(sfx_step);
		sel[1] -= 1;
		if sel[1] < selmin
			sel[1] = selmax;
	
		yoffset = -100;
	
		if holdt == -1
			holdt = 30;
		else
			holdt = 3;
	}
	else if (key_down2 or (holdt == 0 && key_down))
	{
		scr_soundeffect(sfx_step);
		sel[1] += 1;
		if sel[1] > selmax
			sel[1] = selmin;
	
		yoffset = 100;
	
		if holdt == -1
			holdt = 30;
		else
			holdt = 3;
	}
	sel[1] = clamp(sel[1], selmin, selmax);

	if -key_up + key_down == 0
		holdt = -1;
	else if holdt > 0
		holdt--;

	// game
	if -key_left2 && sel[0] > 0
	{
		sel[1] = 0;
	
		scr_soundeffect(sfx_step);
		sel[0] -= 1;
		xoffset = -100;
	
		event_user(0);
	}
	else if key_right2 && sel[0] < array_length(gamearray) - 1
	{
		sel[1] = 0;
	
		scr_soundeffect(sfx_step);
		sel[0] += 1;
		xoffset = 100;
	
		event_user(0);
	}

	// play the song
	if key_jump
	{
		keyboard_clear(global.key_jump);
		event_user(1);
	}
}
else // searching
{
	if (keyboard_check_pressed(vk_enter))
	{
		var eventName = string_trim(keyboard_string)
		show_debug_message("\"" + eventName + "\" - \"" + mu_null + "\"")
		if (!fmod_event_instance_exists(eventName))
		{
			with obj_roomname
			{
				showtext = true;
				message = "SOUND NOT FOUND"
				alarm[0] = 200;
				scr_soundeffect(sfx_pephurt)
			}
		}
		else
		{	
			fmod_release_instance(global.music)
			fmod_stop_all()
	
			global.music = fmod_create_instance(eventName)
			fmod_set_vol(global.music, global.musicvolume, true)
			fmod_set_loop(global.music, true)
			fmod_set_param_from_instance_immediately(global.music, "in_jukebox", true)
			fmod_play_instance(global.music)
		
			global.jukebox = global.music;
			playing = true
		
			with obj_roomname
			{
				showtext = true;
				message = "NOW PLAYING YOUR SOUND"
				alarm[0] = 200;
			}
		}
	}
	if keyboard_check(vk_control)
	{
		if keyboard_check_pressed(ord("C"))
			clipboard_set_text(string_trim(keyboard_string))
		if keyboard_check_pressed(ord("V")) && clipboard_has_text()
			keyboard_string = string_trim(clipboard_get_text())
	}
}

if keyboard_check(vk_control) && keyboard_check(ord("F")) && !searching
{
	searching = true
	scr_soundeffect(sfx_collecttoppin)
	keyboard_string = ""
	if global.jukebox != FMOD_EMPTY
	{
		fmod_release_instance(global.jukebox)
		global.jukebox = FMOD_EMPTY
	}
}
else if keyboard_check_pressed(vk_escape)
{
	searching = false
	if keyboard_check(vk_shift)
	{
		if global.jukebox != FMOD_EMPTY
		{
			fmod_release_instance(global.jukebox)
			global.jukebox = FMOD_EMPTY
			playing = false
		}
	}
}
