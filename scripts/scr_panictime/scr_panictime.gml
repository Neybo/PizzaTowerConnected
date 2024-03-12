function scr_panictime()
{
	// set global timer based on stage
	var roomname = room_get_name(room);
	roomname = string_replace(roomname, "_NEW", "");
	switch roomname
	{
		default:
			global.minutes = 2
			global.seconds = 59
			break
		
		case "entrance_10":
			global.minutes = 2
			global.seconds = 30
			break
		
		case "medieval_10":
			global.minutes = 2
			global.seconds = 15
			break
		
		case "ruin_11":
			global.minutes = 2
			global.seconds = 59
			break
		
		case "dungeon_10":
			global.minutes = 4
			global.seconds = 30
			break
	
		case "chateau_6":
			global.minutes = 3
			global.seconds = 15
			break
	
		case "strongcold_1":
			global.minutes = 3
			global.seconds = 59
			break
	
		case "floor1_room11":
			global.minutes = 2
			global.seconds = 59
			break
	
		case "graveyard_6":
			global.minutes = 3
			global.seconds = 59
			break
	
		case "farm_11":
			global.minutes = 3
			global.seconds = 59
			break
		
		case "ufo_12":
			global.minutes = 2
			global.seconds = 30
			break
		
		case "beach_13":
			global.minutes = 3
			global.seconds = 59
			break
		
		case "forest_5":
			global.minutes = 3
			global.seconds = 30
			break
		
		case "kungfu_10":
			global.minutes = 6
			global.seconds = 30
			break
		
		case "minigolf_8":
			global.minutes = 7
			global.seconds = 30
			break
		
		case "space_9":
			global.minutes = 5
			global.seconds = 30
			break
		
		case "mansion_7":
			global.minutes = 5
			global.seconds = 30
			break
		
		case "factory_10":
			global.minutes = 6
			global.seconds = 30
			break
		
		case "freezer_3":
			global.minutes = 5
			global.seconds = 30
			break
		
		case "war_1":
			global.minutes = 8
			global.seconds = 59
			break
		
		case "exit_1":
			global.minutes = 9
			global.seconds = 59
			break
		
		case "kidsparty_lastroom":
			global.minutes = 3
			global.seconds = 30
			break
		
		case "oldsewer_treasure":
			global.minutes = 2
			global.seconds = 30
			break
		
		case "oldfactory_treasure":
			global.minutes = 2
			global.seconds = 30
			break
		
		case "oldmansion_treasure":
			global.minutes = 3
			global.seconds = 15
			break

		case "oldfreezer_11":
			global.minutes = 1
			global.seconds = 59
			break
		
		case "golf_treasure":
			global.minutes = 1
			global.seconds = 59
			break
		
		case "etb_8":
			global.minutes = 2
			global.seconds = 59
			break
		case "tower_finalhallway":
			global.minutes = 5
			global.seconds = 33
			break;
	}
	
	// sugary spire level timers go here and dont you dare ask me why
	// why
	switch roomname
	{	
		case "dragonlair_1":
			global.minutes = 0
			global.seconds = 59
			break
		
		case "cotton_12":
			global.minutes = 3
			global.seconds = 59
			break
			
		case "entryway_11":
			global.minutes = 2
			global.seconds = 29
			break
		
		case "molasses_9":
			global.minutes = 4
			global.seconds = 59
			break
	}
	
	// extend timer in the careful modifiers
	if global.modifier == mods.no_toppings or global.modifier == mods.pacifist
	{
		global.minutes *= 1.5;
		global.minutes = floor(global.minutes);
		
		if global.seconds == 30
			global.seconds = 29;
			
		global.seconds *= 2;
		if global.seconds >= 60
		{
			global.minutes += 1;
			global.seconds -= 60;
		}
			
		if global.seconds > 0 && global.seconds < 20
			global.seconds = 15;
		if global.seconds > 20 && global.seconds < 40
			global.seconds = 29;
		if global.seconds > 40
			global.seconds = 59;
	}
	scr_panictimemusic()
	return true;
}

function scr_panictimemusic()
{
	with obj_music
	{
		if fmod_is_instance_playing(global.jukebox)
			return; // fix panic issues
		var musplay = FMOD_EMPTY
		
		if global.panic && (!(string_contains(roomname, "secret")) 
		or OLD_GAMEPLAY)
		&& ((string_letters(roomname) != "dragonlair" && string_letters(roomname) != "grinch"
		&& !string_contains(roomname, "base_"))
		or scr_checkskin(checkskin.p_anton))
		{
			// war level
			if global.lap >= 99
				musplay = mu_laphell
			else if string_startswith(roomname, "war")
			{
				if global.wartimer
					musplay = mu_war;
				else
					musplay = mu_warintro;
			}
			else if string_startswith(roomname, "tower")
				musplay = mu_finalescape
			else if string_startswith(roomname, "exit")
				musplay = mu_fakepeppart1
			else
			{
				// antonball
				if scr_checkskin(checkskin.p_anton)
				{
					if (OLD_GAMEPLAY)
					musplay = mu_antonescape;
					else
					musplay = mu_antonescape_NEW
				}
				// pizza time
				else
					{
						switch obj_player.character
						{
							default:
								var trim_lap = string_copy(mu_lap3, 1, string_length(mu_lap3) - 1)
								var max_lap_theme = 5
								if (global.lap > 1)
									musplay = trim_lap + string(min(global.lap + 1, max_lap_theme))
							    else if (global.lap2)
									musplay = mu_chase
								else
									musplay = OLD_GAMEPLAY ? mu_pizzatime_OLD : mu_pizzatime; 
								break;
							case "N": // silly thing for v and n
								if (global.lap2)
									musplay = mu_noiseescape_OLD;
								else
									musplay = mu_noiseescape; 
								break;
							case "V":
								if (!global.lap2)
									musplay = mu_noiseescape_OLD;
								else
									musplay = mu_noiseescape; 
								break;
							case "S":
								if (global.lap2)
									musplay = mu_collapse;
								else
									musplay = mu_snickescape; 
								break;
							
							case "PP":
								musplay = mu_pizzatime_PP;
								if global.streamer
									musplay = mu_pizzatime_PP_streamer;
								else if global.lap2
									musplay = mu_chase_PP
								break;
							
							case "SN":
							case "SP":
								if global.lap >= 4
									musplay = mu_sucrose
								else if (global.lap >= 2)
									musplay = mu_pizzyescapelap3
							   else if (global.lap2)
									musplay = mu_pizzyescapelap2
								else
									musplay = obj_player.character == "SN" ? mu_bluelicorice :
									(OLD_GAMEPLAY ? mu_pizzyescape_OLD : mu_pizzyescape);
								break;
						}
					}
			}
			var musname = fmod_get_instance_name(global.music)
			if (musname != musplay
			&& !string_contains(musname, "secret"))
			{
				panicfadeoff = 0;
				fadeoff = 0;
			}
		}
		if musplay != FMOD_EMPTY
		{
			// event:/PIZZA CASTLE
			if global.musicgame == 1
				musplay = scr_getmidi(musplay);		

			// actually play the song
			if fmod_get_instance_name(global.music) != musplay 
			&& !obj_pause.pause
			{
				fmod_stop_instance_immediately(global.music);
				scr_sound(musplay);
				if global.panic
					fmod_set_instance_timeline_pos(global.music, panicfadeoff);
			}
		}
	}
}