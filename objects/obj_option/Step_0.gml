scr_getinput(true);

//Move Up and down
if menuto != -1
{
	if menuto < menu
	{
		camx = lerp(camx, -960, -0.5);
		if camx >= 960
		{
			if menu == menustates.audio
				optionselected = 3;
			if menu == menustates.otherop
				optionselected = 5;
			if menu == menustates.ptox
				optionselected = 6;

			menu = menuto;
			menuto = -1;
			camx = -960;
		}
	}
	else
	{
		camx = lerp(camx, 960, -0.5);
		if camx <= -960
		{
			menu = menuto;
			menuto = -1;
			camx = 960;
		}
	}
	exit;
}
else
	camx = lerp(camx, 0, 0.25);

if !instance_exists(obj_keyconfig) && !instance_exists(obj_erasegame)
&& !instance_exists(obj_langconfig)
{
	if !(instance_exists(obj_pause) && obj_pause.pause)
		omax = 7;
	else
		omax = 4;
	
	if menu == menustates.audio
		omax = 5;
	if menu == menustates.otherop
		omax = 15;
	if menu == menustates.ptox
		omax = ptox_option_count;
	
	var mov = -(key_up2 or keyboard_check_pressed(vk_up)) 
			+ (key_down2 or keyboard_check_pressed(vk_down));
	var movh = -(key_up or keyboard_check(vk_up)) + (key_down or keyboard_check(vk_down));
	
	if movh == 0
	{
		holdkey = -1;
		holdkeyt = 20;
	}
	else
		holdkey = 0
		
	if holdkey == 0
	{
		holdkeyt--;
		if holdkeyt <= 0
		{
			holdkeyt = 5;
			randomize()
			scr_soundeffect_pitch(menu != menustates.main ? sfx_step : sfx_dressermove, random_range(1, 1)) // im doing it like this just to be annoying
			mov = movh;
		}
	}
	
	if mov != 0
	{
		optionselected += mov
		if optionselected < 0
			optionselected = (menu >= 1) ? omax : 0
		else if optionselected > omax
			optionselected = (menu >= 1) ? 0 : omax
		
		scr_soundeffect_pitch(menu != menustates.main ? sfx_step : sfx_dressermove, random_range(1, 1))
	}
}

#region main options
if menu == menustates.main
{
	//Full Screen
	if optionselected == 0
	{
		if (key_right2 or keyboard_check_pressed(vk_right)) && optionsaved_fullscreen == 0
		{
			scr_soundeffect(sfx_step)
			optionsaved_fullscreen = 1
		}
		if (-key_left2 or keyboard_check_pressed(vk_left)) && optionsaved_fullscreen == 1
		{
			scr_soundeffect(sfx_step)
			optionsaved_fullscreen = 0
		}
		
		if key_jump or keyboard_check_pressed(vk_enter)
		{
			randomize()
			scr_soundeffect(sfx_menuchoose);
			
			ini_open("saveData.ini");
			global.option_fullscreen = !optionsaved_fullscreen
			ini_write_real("Option", "fullscreen", global.option_fullscreen)  
			ini_close();
			
			window_set_fullscreen(global.option_fullscreen);
			
			with obj_roomname
			{
				showtext = true;
				message = lang_str_upper("options.saved");
				alarm[0] = 60;
			}
		}
	}
	else
		optionsaved_fullscreen = !global.option_fullscreen;
	
	//Resolution
	if optionselected == 1
	{
		if (key_right2 or keyboard_check_pressed(vk_right)) && optionsaved_resolution < 2
		{
			scr_soundeffect(sfx_step)
			optionsaved_resolution += 1
		}
		
		if (-key_left2 or keyboard_check_pressed(vk_left)) && optionsaved_resolution > 0
		{
			scr_soundeffect(sfx_step)
			optionsaved_resolution -= 1
		}
		
		if key_jump or keyboard_check_pressed(vk_enter)
		{
			randomize()
			scr_soundeffect(sfx_menuchoose);
			
			ini_open("saveData.ini");
			global.option_resolution = optionsaved_resolution
			ini_write_real("Option", "resolution", global.option_resolution)  
			ini_close();
			
			if !window_get_fullscreen()
			{
				switch optionsaved_resolution
				{
					case 0: window_set_size( 480, 270 ); break;
					case 1: window_set_size( 960, 540 ); break;
					case 2: window_set_size( 1920, 1080 ); break;
				}
			}
			
			with obj_roomname
			{
				showtext = true;
				message = lang_str_upper("options.saved");
				alarm[0] = 60;
			}
		}
	}
	else
		optionsaved_resolution = global.option_resolution;
	
	// key config
	if optionselected == 2 && !instance_exists(obj_keyconfig)
	&& ((key_jump or keyboard_check_pressed(vk_enter)))
	{
		scr_soundeffect(sfx_step)
		visible = false
		instance_create(x, y, obj_keyconfig)
	}
	
	// audio settings
	if optionselected == 3 && !instance_exists(obj_keyconfig)
	&& ((key_jump or keyboard_check_pressed(vk_enter)))
	{
		scr_soundeffect(sfx_step)
		menuto = menustates.audio
		optionselected = 0
		camy = 0
		
		if instance_exists(obj_music) && global.musicvolume > 0
			music = global.music;
	}
	
	// gamepad vibration
	if optionselected == 4
	{
		if (key_right2 or keyboard_check_pressed(vk_right)) && optionsaved_vibration == 0
		{
			scr_soundeffect(sfx_step)
			optionsaved_vibration = 1
		}
		if (-key_left2 or keyboard_check_pressed(vk_left)) && optionsaved_vibration == 1
		{
			scr_soundeffect(sfx_step)
			optionsaved_vibration = 0
		}
		
		if key_jump or keyboard_check_pressed(vk_enter)
		{
			randomize()
			scr_soundeffect(sfx_menuchoose);
			global.gamepadvibration = !optionsaved_vibration
			
			ini_open("saveData.ini");
			ini_write_real("online", "gamepadvibration", global.gamepadvibration)  
			ini_close();
			
			gp_vibration(1, 1, 0.9);
			
			with obj_roomname
			{
				showtext = true;
				message = lang_str_upper("options.saved");
				alarm[0] = 60;
			}
		}
	}
	else
		optionsaved_vibration = !global.gamepadvibration;

	
	// other options
	if optionselected == 5 && !instance_exists(obj_keyconfig)
	&& ((key_jump or keyboard_check_pressed(vk_enter)))
	{
		randomize()
		scr_soundeffect(sfx_menuchoose);
		menuto = menustates.otherop
		optionselected = 0
		camy = 0
	}
	
	// ptox mf
	if optionselected == 6 && !instance_exists(obj_keyconfig)
	&& ((key_jump or keyboard_check_pressed(vk_enter)))
	{
		randomize()
		scr_soundeffect(sfx_menuchoose);
		menuto = menustates.ptox
		optionselected = 0
		camy = 0
	}
	
	if optionselected == 7 && !instance_exists(obj_langconfig)
	&& ((key_jump or keyboard_check_pressed(vk_enter))) && !instance_exists(obj_keyconfig) 
	{
		scr_soundeffect(sfx_step)
		visible = false
		instance_create(x, y, obj_langconfig)
	}

	//Finish
	if (key_slap2 or keyboard_check_pressed(vk_escape)) && !instance_exists(obj_keyconfig)
	&& !instance_exists(obj_langconfig)
	{
		scr_soundeffect(sfx_dresserback)
		with obj_player
			state = 0;
		
		instance_destroy()
		//audio_stop_sound(mu_editor);
		
		//if audio_is_playing(global.jukebox)
		//	audio_pause_sound(global.jukebox);
	}
}
#endregion
#region sound options
else if menu == menustates.audio
{
	// master volume slider
	if optionselected == 0
	{
		if keyboard_check(vk_shift)
			var move = (key_left2 + key_right2) * 0.01;
		else
			var move = (key_left + key_right) * 0.02;
		
		global.mastervolume = clamp(global.mastervolume + move, 0, 1);
		if keyboard_check_pressed(ord("R"))
			global.mastervolume = 1;
	}
	fmod_set_param_master("master_vol", global.mastervolume * 0.75);
	
	// music volume slider
	if optionselected == 1
	{
		if keyboard_check(vk_shift)
			var move = (key_left2 + key_right2) * 0.01;
		else
			var move = (key_left + key_right) * 0.02;
		
		if keyboard_check_pressed(ord("R"))
			global.musicvolume = 0.6;
		
		global.musicvolume = clamp(global.musicvolume + move, 0, 1);
		fmod_set_vol(music, global.musicvolume, false);
		
		if global.musicvolume > 0 && !fmod_is_instance_playing(music)
		{
			if !instance_exists(obj_music)
			{
				global.music = FMOD_EMPTY;
				global.jukebox = FMOD_EMPTY;
				music = scr_soundeffect_ext(mu_editor);
			}
			else
			{
				with obj_music
				{
					forcefadeoff = 4.8;
					event_perform(ev_other, ev_room_start);
				}
				music = global.music;
			}
		}
	}
	
	// sound volume??
	if optionselected == 2
	{
		if keyboard_check(vk_shift)
			var move = (key_left2 + key_right2) * 0.01;
		else
			var move = (key_left + key_right) * 0.02;

		global.soundvolume = clamp(global.soundvolume + move, 0, 1);
		if keyboard_check_pressed(ord("R"))
			global.soundvolume = 1;
	
	}
	
	// mach sound
	if optionselected == 3
	{
		fmod_set_vol(global.music, min(global.musicvolume, 0.2), false);
		var changed = false
		if (key_right2 or keyboard_check_pressed(vk_right)) && global.machsound == 1
		{
			changed = true
			global.machsound = 0
		}
		if (-key_left2 or keyboard_check_pressed(vk_left)) && global.machsound == 0
		{
			changed = true
			global.machsound = 1
		}
		
		if !fmod_is_instance_playing(pmach2_new) && global.machsound == 0
			fmod_play_instance(pmach2_new)
		if !fmod_is_instance_playing(pmach2_old) && global.machsound == 1
			fmod_play_instance(pmach2_old)
			
		if global.machsound == 0
			fmod_stop_instance_immediately(pmach2_old);
		else
			fmod_stop_instance_immediately(pmach2_new);
		if changed
			with obj_player
				scr_playersounds_refresh()
	}
	else
	{
		fmod_set_vol(global.music, global.musicvolume, false);
		fmod_stop_instance_immediately(pmach2_new);
		fmod_stop_instance_immediately(pmach2_old);
	}
	
	// tower and castle
	if optionselected == 4
	{
		var mgprev = global.musicgame;
		if (key_right2 or keyboard_check_pressed(vk_right)) && global.musicgame < 1
			global.musicgame++;
		if (-key_left2 or keyboard_check_pressed(vk_left)) && global.musicgame > 0
			global.musicgame--;
		
		// refresh music
		if global.musicgame != mgprev && global.jukebox == FMOD_EMPTY
		{
			if instance_exists(obj_music)
			{
				fmod_release_instance(global.music);
				global.music = FMOD_EMPTY
				fmod_release_instance(music);
				
				with obj_music
					event_perform(ev_alarm, 1);
				music = global.music;
			}
			else
			{
				fmod_release_instance(global.music);
				global.music = FMOD_EMPTY;
				scr_soundeffect(sfx_step);
			}
		}
	}
	
	// mute untab
	if optionselected == 5
	{
		
		var mgprev = global.muteuntabbed;
		if (key_right2 or keyboard_check_pressed(vk_right)) && global.muteuntabbed < 1
			global.muteuntabbed++;
		if (-key_left2 or keyboard_check_pressed(vk_left)) && global.muteuntabbed > 0
			global.muteuntabbed--;
		
		// refresh music
		if global.muteuntabbed != mgprev
		{
			scr_soundeffect(sfx_step);
		}
	}
	
	//Finish
	if (key_slap2 or keyboard_check_pressed(vk_escape)) && !instance_exists(obj_keyconfig)
	{
		scr_soundeffect(sfx_dresserback);
		menuto = menustates.main
			
		fmod_set_vol(global.music, global.musicvolume);
		
		fmod_stop_instance_immediately(pmach2_new);
		fmod_stop_instance_immediately(pmach2_old);
		
		ini_open("saveData.ini");
		ini_write_real("online", "musicvolume", global.musicvolume)  
		ini_write_real("online", "mastervolume", global.mastervolume)
		ini_write_real("online", "soundvolume", global.soundvolume)
		ini_write_real("online", "machsound", global.machsound)
		ini_write_real("online", "musicgame", global.musicgame)		
		ini_write_real("online", "muteuntabbed", global.muteuntabbed)
		ini_close();

		with obj_player
			scr_playersounds_refresh()
		
		if global.musicvolume <= 0 && fmod_is_instance_playing(global.music)
		{
			fmod_release_instance(global.music);
			global.jukebox = FMOD_EMPTY;
		}
		
		with obj_roomname
		{
			showtext = true;
			message = lang_str_upper("options.saved");
			alarm[0] = 60;
		}
	}
}
#endregion
#region other options
else if menu == menustates.otherop && !instance_exists(obj_erasegame)
{
	var select = key_jump or keyboard_check_pressed(vk_enter);
	
	// erase game
	if optionselected == 0 && select
	{
		randomize()
		scr_soundeffect(sfx_menuchoose);
		visible = false
		instance_create(x, y, obj_erasegame)
	}
	
	// gameplay style
	if optionselected == 1
	{
		var move = key_left2 + key_right2;
		if select
		{
			global.gameplay++;
			randomize()
			scr_soundeffect(sfx_menuchoose);
		}
		else if move != 0
		{
			global.gameplay += move;
			randomize()
			scr_soundeffect(sfx_menuchoose);
		}
		if global.gameplay > 2
			global.gameplay = 0;
		if global.gameplay < 0
			global.gameplay = 2;
		if obj_player.character == "P"
		{
			with obj_player
			{
				spr_machclimbwall = (OLD_GAMEPLAY) ? spr_player_climbwall : spr_player_climbwall_NEW
			}
		}
	}
	
	// panic bg
	if optionselected == 2 && select
	{
		if check_shaders()
		{
			global.panicbg = !global.panicbg;
			randomize()
			scr_soundeffect(sfx_menuchoose);
		}
		else
			scr_soundeffect(sfx_denied);
	}
	
	// panic melt
	if optionselected == 3
	{
		if select
		{
			global.panicmelt = !global.panicmelt;
			randomize()
			scr_soundeffect(sfx_menuchoose);
		}
	}
	
	// panic shake
	if optionselected == 4
	{
		if select
		{
			global.panicshake = !global.panicshake;
			randomize()
			scr_soundeffect(sfx_menuchoose);
		}
	}
	
	// panic change bg
	if optionselected == 5
	{
		if select
		{
			global.panicnightmare = !global.panicnightmare;
			randomize()
			scr_soundeffect(sfx_menuchoose);
		}
	}
	
	// secret debris
	if optionselected == 6
	{
		if select
		{
			global.secretdebris = !global.secretdebris;
			randomize()
			scr_soundeffect(sfx_menuchoose);
		}
	}
	
	// show names
	if optionselected == 7
	{
		if select
		{
			global.shownames = !global.shownames;
				randomize()
			scr_soundeffect(sfx_menuchoose);
		}
	}
	
	// chat bubbles
	if optionselected == 8
	{
		if select
		{
			global.chatbubbles = !global.chatbubbles;
			randomize()
			scr_soundeffect(sfx_menuchoose);
		}
	}
	
	// sync effects
	if optionselected == 9
	{
		if select
		{
			global.synceffect = !global.synceffect;
			randomize()
			scr_soundeffect(sfx_menuchoose);
		}
	}
	
	// pvp
	if optionselected == 10
	{
		if select
		{
			global.pvp = !global.pvp;
			randomize()
			scr_soundeffect(sfx_menuchoose);
		}
	}
	
	// streamer
	if optionselected == 11
	{
		if select
		{
			global.streamer = !global.streamer;
			randomize()
			scr_soundeffect(sfx_menuchoose);
		}
	}
	
	// drpc
	if optionselected == 12
	{
		if select
		{
			global.richpresence = !global.richpresence;
			randomize()
			scr_soundeffect(sfx_menuchoose);
		}
	}
	
	// fps count
	if optionselected == 13
	{
		if select
		{
			global.showfps = !global.showfps;
			randomize()
			scr_soundeffect(sfx_menuchoose);
		}
	}
	
	// camera smoothing slider
	if optionselected == 14
	{
		if keyboard_check(vk_shift)
			var move = (key_left2 + key_right2) * 0.01;
		else
			var move = (key_left + key_right) * 0.02;
		
		global.camerasmoothing = clamp(global.camerasmoothing + move, 0, 1);
	}
	
	// input display
	if optionselected == 15
	{
		if global.inputdisplay
		{
			var move = (key_left2 + key_right2) * (2 - key_attack);
			var upordown = keyboard_check_pressed(vk_control)
			if upordown
			{
				substate = !substate
			}
			with obj_inputdisplay
			{
				if other.substate == 1
				{
					keysep += move
				}
				else
				{
					keysize += move
				}
				if move != 0
				{
					pos[1] = (520 - keysize * 3) - keysep * 3;
					savekeys()
				}
			}
		}
		if select
		{
			global.inputdisplay = !global.inputdisplay;
			randomize()
			scr_soundeffect(sfx_menuchoose);
			
		}
	}
	
	//Finish
	if (key_slap2 or keyboard_check_pressed(vk_escape)) && !instance_exists(obj_keyconfig)
	{
		scr_soundeffect(sfx_dresserback)
		menuto = menustates.main
		
		ini_open("saveData.ini");
		ini_write_real("online", "gameplay", global.gameplay)
		//with obj_player
		//	noisetype = (OLD_GAMEPLAY ? 0 : 1);
		
		ini_write_real("online", "panicmelt", global.panicmelt)  
		ini_write_real("online", "panicbg", global.panicbg)  
		ini_write_real("online", "panicshake", global.panicshake)
		ini_write_real("online", "panicnightmare", global.panicnightmare)
		
		ini_write_real("online", "secretdebris", global.secretdebris)
		ini_write_real("online", "shownames", global.shownames)
		ini_write_real("online", "chatbubbles", global.chatbubbles)
		ini_write_real("online", "synceffect", global.synceffect)
		ini_write_real("online", "pvp", global.pvp)
		ini_write_real("online", "richpresence", global.richpresence)
		ini_write_real("online", "streamer", global.streamer)
		ini_write_real("online", "showfps", global.showfps)
		ini_write_real("online", "camerasmoothing", global.camerasmoothing)
		ini_write_real("online", "inputdisplay", global.inputdisplay)
		ini_write_real("online", "gamepadvibration", global.gamepadvibration)
		
		ini_close();
		
		if global.hudstyle == 2
			global.hudtype = min(global.gameplay, 1)
		else
			global.hudtype = global.hudstyle

		if global.levelstyle == 2
			global.leveltype = min(global.gameplay, 1)
		else
			global.leveltype = global.levelstyle
		
		if obj_drpc_updater.running != global.richpresence
		{
			with obj_drpc_updater
			{
				if !running
					event_user(0);
				else
					event_user(1);
			}
		}
		
		if variable_global_exists("__chat_bubbles")
			global.__chat_bubbles = global.chatbubbles;
		
		with obj_roomname
		{
			showtext = true;
			message = lang_str_upper("options.saved");
			alarm[0] = 60;
		}
	}
}
#endregion
#region ptox
if menu == menustates.ptox
{
	optionr_handle_update(options_categories_ptox)
	if (key_slap2 or keyboard_check_pressed(vk_escape)) && !instance_exists(obj_keyconfig)
		optionr_handle_exit(options_categories_ptox)
}
#endregion