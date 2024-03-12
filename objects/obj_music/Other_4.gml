// prepare
if wait
{
	alarm[1] = 1;
	exit;
}

if global.musicvolume <= 0
{
	fmod_release_instance(global.music);
	exit;
}
if fmod_is_instance_playing(global.jukebox) || fmod_is_instance_playing(adminmus)
{
	//show_debug_message("jukebox is playing")
	exit;
}
else if adminmus != FMOD_EMPTY
{
	fmod_release_instance(adminmus)
	adminmus = FMOD_EMPTY;
}
//show_debug_message("jukebox not is playing")
roomname = room_get_name(room)
if string_endswith(roomname, "_NEW")
	roomname = string_replace(roomname, "_NEW", "");

var musplay = FMOD_EMPTY;
if room == racing_results
	musplay = mu_raceresultwin
else if scr_checkskin(checkskin.p_anton)
{
	// ANTONBALL
	if !global.panic && !global.snickchallenge
	{
		if string_contains(roomname, "secret")
			musplay = mu_antonsecret;
		else if room == hub_arcade or room == hub_roomPLN
			musplay = mu_antonsage;
		else if room == hub_outside3b2
			musplay = mu_antonpunchball;
		else if room != rank_room && room != timesuproom
			musplay = mu_antonlevel;
	}
}
else if (!global.panic or string_letters(roomname) == "dragonlair" 
or string_letters(roomname) == "grinch" or string_contains(roomname, "base_")
or (string_contains(roomname, "secret") && FINAL_GAMEPLAY))
&& !global.snickchallenge
{
	// room number
	var roomnumber = string_digits(string_replace(string_replace(roomname, "floor1", "floor"), "d2factory", "dfactory"));
	if string_is_number(roomnumber)
		roomnumber = real(roomnumber);
	else
		roomnumber = 0;
	
    if string_letters(roomname) == "Realtitlescreen" or string_letters(roomname) == "Realtitlescreen"
	{
		fadeoff = 0
		musplay = mu_title
	}
	else if string_startswith(roomname, "hub_room") 
	or string_letters(roomname) == "halloweenentrance" or room == hub_DEMO
	{
		if fmod_get_instance_name(global.music) == mu_tutorial
			fadeoff = 0;
		
		musplay = mu_hub
	}
	if string_startswith(roomname, "hub_outside")
		musplay = mu_hub2
	else if string_startswith(roomname, "hub_arcade")
		musplay = mu_hubarcade
	else if string_startswith(roomname, "hub_roomSP") or string_startswith(roomname, "sugary_outer")
	{
		fadeoff = 0
		musplay = mu_sugaryhub
	}
	else if string_startswith(roomname, "hub_roomE")
	{
		if fmod_get_instance_name(global.music) == mu_mall
			fadeoff = 0;	
		musplay = mu_hube
	}
	else if room == hub_shop || string_startswith(roomname, "rm_test")
	{
		fadeoff = 0
		musplay = mu_mall
	}
	else if room == tower_entrancehall || room == tower_johngutterhall || room == tower_1
		musplay = mu_hub
	else if room == tower_2
		musplay = mu_tuesdays
	else if room == tower_3
		musplay = mu_wednesdays
	else if room == tower_4
		musplay = mu_thursdays
	else if room == tower_5
		musplay = mu_fridays
	
	else if string_letters(roomname) == "PProom"
	{
		fadeoff = 0
		musplay = mu_tutorial
	}
	
	if string_letters(roomname) == "entrance"
	or (string_letters(roomname) == "entryway")
	{
		switch obj_player.character
		{
			default: musplay = mu_entrance break
			case "N": case "V": musplay = mu_noiseentrance break
			case "S": musplay = mu_snickentrance break
			case "SP": musplay = mu_waffle break
		}
	}
	
	if string_letters(roomname) == "dungeon"
	{
		musplay = !global.snickrematch ? mu_dungeon : mu_dungeon_re;
		if roomnumber > 8
		{
			fadeoff = 0;
			musplay = !global.snickrematch ? mu_dungeondepth : mu_dungeondepth_re;
		}
	}
	
	if string_letters(roomname) == "strongcold"
	{
		musplay = mu_strongcold
		if roomnumber == 1
		{
			fadeoff = 0
			musplay = (obj_player.character == "PP") ? mu_chateau_PP : mu_chateau
		}
		else if roomnumber > 8
		{
			fadeoff = 0
			musplay = mu_dungeondepth
		}
	}
	
	if string_letters(roomname) == "d2factory"
	{
		musplay = mu_industrial
		if roomnumber > 8
		{
			fadeoff = 0
			musplay = mu_factory
        }
	}
	if string_letters(roomname) == "d2factorybase"
		musplay = mu_factoryescape
	
	if string_letters(roomname) == "medieval" 
	{
		if global.snickrematch
			musplay = mu_phantom
		else
		{
			if roomnumber <= 2
				musplay = mu_medievalentrance;
			else if roomnumber <= 5
				musplay = mu_medievalremix;
			else
				musplay = mu_medieval;
		}
	}

	if string_letters(roomname) == "ruin" 
	{
		if global.snickrematch
			musplay = mu_apartment
		else
		{
			musplay = mu_ruin;
			if roomnumber > 6
				musplay = mu_ruinremix;
		}
	}
	
	if string_letters(roomname) == "FINALruin" 
	{
			fadeoff = 0;
			musplay = mu_ruin;	
			if roomnumber > 5
				musplay = mu_ruinremix;
	}

	if string_letters(roomname) == "chateau"
		musplay = mu_chateau
		
	if string_letters(roomname) == "FINALdungeon"
		musplay = mu_FINALdungeon
	
	if string_letters(roomname) == "farm" 
		musplay = mu_farm
	
	if string_letters(roomname) == "graveyard" 
		musplay = mu_graveyard

	if string_letters(roomname) == "saloon" || room == saloon_5b
		musplay = mu_saloon

	if string_letters(roomname) == "ufo" 
		musplay = mu_pinball;

	if string_letters(roomname) == "dragonlair"
		musplay = mu_dragonlair

	if string_letters(roomname) == "beach" 
		musplay = mu_beach
		
	if string_startswith(roomname, "cafe")
		musplay = mu_cafe
		
	if string_letters(roomname) == "city" 
	{
		fadeoff = 0
		if roomnumber > 6
			musplay = mu_clown
		else
			musplay = mu_city
	}
	
	if string_letters(roomname) == "hubdanceroom"
	{
		fadeoff = 0
		if global.gameplay = 0
			musplay = mu_null
		else
			musplay = mu_nullfinal
	}
	
	if string_letters(roomname) == "forest" 
	{
		musplay = mu_gnomeforest;
		if roomnumber < 4
			musplay = mu_forest;
		if roomnumber == 4
		{
			fadeoff = 0;
			musplay = mu_gustavo;
		}
	}
	
	if string_letters(roomname) == "FINALforest" 
		musplay = mu_forest;
	
	if string_letters(roomname) == "kungfu" 
		musplay = mu_kungfu
	
	if string_startswith(roomname, "golf_")
	or string_letters(roomname) == "minigolf"
	{
		musplay = mu_minigolf;
		if obj_player.character == "PP"
			musplay = mu_susgolf;
	}
	
	if string_startswith(roomname, "war")
	{
		if global.wartimer
			musplay = mu_war;
		else
			musplay = mu_warintro;
	}
	
	if string_letters(roomname) == "space"
	{
		musplay = mu_pause
		if roomnumber > 4
			musplay = mu_spaceB
		if obj_player.character == "S"
			musplay = mu_space_snick
		if is_holiday(holidays.halloween)
			musplay = mu_space_spooky
	}
	
	if string_startswith(roomname, "cotton")
	{
		musplay = mu_cotton;
		if roomnumber >= 8
			musplay = mu_cotton2;
	}
	if string_startswith(roomname, "molasses")
		musplay = mu_swamp
	if string_startswith(roomname, "mines")
		musplay = mu_mines
	if string_startswith(roomname, "sugarytut")
	{
		fadeoff = 0
		musplay = mu_tutorial_ss
	}	
	// desert
	if string_startswith(roomname, "floor1_room")
	or string_startswith(roomname, "floor1_mart")
	{
		musplay = mu_desert;
		if roomnumber > 9
			musplay = mu_ufo;
	}

	// freezer
	if string_startswith(roomname, "oldfreezer_")
	{
		if global.gameplay = 0
		musplay = mu_freezer;
		else
		musplay = mu_freezernew;
		if roomnumber > 6
			musplay = mu_freezer2;
	}

	// sewer
	if string_startswith(roomname, "oldsewer_")
	{
		musplay = mu_sewer;
		if roomnumber > 5
		{
			if fmod_get_instance_name(global.music) == mu_sewer
				fadeoff = 0
			musplay = mu_sewer2
		}
	}

	// factory
	if string_startswith(roomname, "oldfactory_") || string_letters(roomname) == "dfactory"
		musplay = mu_factory

	// etb
	if string_startswith(roomname, "etb_")
	{
		if roomnumber == 1
		{
			fadeoff = 0
			musplay = mu_tutorial
		}
		else
		{
			if fmod_get_instance_name(global.music) == mu_tutorial
				fadeoff = 0;
			
			if scr_checkskin(checkskin.p_peter) && global.musicgame != 1
				musplay = music_onepizzaatatime
			else
				musplay = mu_ruin
		}
	}
	
	// ancient
	if string_letters(roomname) == "ancient"
	{
		musplay = mu_ancient;
		if roomnumber > 19
			musplay = mu_pepperman
	}
	// grinch
	if string_letters(roomname) == "grinch"
		musplay = mu_christmas;
		
	if string_letters(roomname) == "dancientbase"
		musplay = mu_ancientescape
	if string_letters(roomname) == "dfactorybase"
		musplay = mu_factoryescape
	if string_letters(roomname) == "kidsparty"
		musplay = mu_kids
	if string_letters(roomname) == "FINALentrance"
		musplay = mu_entrance
	if string_startswith(roomname, "FINALentrance_secret")
		musplay = mu_entrancesecret
	// water
	/*
	if string_letters(roomname) == "water"
		musplay = mu_waterlevel;
	*/
	
	// mansion
	if string_startswith(roomname, "oldmansion_")
	{
		musplay = mu_mansion;
		if roomnumber > 8
			musplay = mu_mansionoutside;
	}
	
	// secrets
	if instance_exists(obj_randomsecret)
	{
		musplay = mu_secretsaroundtheworld
	}
	else
	{
		if string_letters(roomname) == "entrancesecret"
		{
			musplay = mu_entrancesecret
			with obj_player
			{
				if character == "PP" musplay = mu_entrancesecretPP;
				if character == "N" musplay = mu_entrancesecret
			}
		}
		if string_letters(roomname) == "medievalsecret"
		or string_letters(roomname) == "ancientsecret"
		{
			musplay = mu_medievalsecret
			if global.snickrematch
				musplay = mu_medievalsecret_re;
		}
		if string_letters(roomname) == "ruinsecret"
		or string_startswith(roomname, "FINALruin_secret")
		or string_letters(roomname) == "etbsecret"
		{
			musplay = mu_ruinsecret
			if global.snickrematch
				musplay = mu_ruinsecret_re;
		}
		if string_letters(roomname) == "dungeonsecret"
		{
			musplay = mu_dungeonsecret
			if global.snickrematch
				musplay = mu_dungeonsecret_re
		}
		if string_startswith(roomname, "FINALdungeon_secret")
			musplay = mu_dungeonsecret
		if string_letters(roomname) == "chateausecret" 
			musplay = mu_chateausecret
		if string_letters(roomname) == "strongcoldsecret"
			musplay = mu_strongcoldsecret
		if string_startswith(roomname, "floor1_secret")
			musplay = mu_desertsecret
		if string_startswith(roomname, "oldmansion_secret")
			musplay = mu_mansionsecret
		if string_startswith(roomname, "oldsewer_secret")
			musplay = mu_sewersecret
		if string_letters(roomname) == "graveyardsecret" 
			musplay = mu_graveyardsecret
		
		if string_letters(roomname) == "saloonsecret" 
			musplay = mu_saloonsecret
	
		if string_letters(roomname) == "farmsecret" 
			musplay = mu_farmsecret
		if string_letters(roomname) == "ufosecret" 
			musplay = mu_pinballsecret
		if string_letters(roomname) == "forestsecret"
			musplay = (roomnumber > 1) ? mu_forestsecretPECKER : mu_forestsecret
		if string_letters(roomname) == "beachsecret"
			musplay = mu_beachsecret
		if string_letters(roomname) == "kungfusecret" 
			musplay = mu_kungfusecret
		if string_letters(roomname) == "spacesecret"
		{
			musplay = mu_pausesecret
		}
		if string_letters(roomname) == "entrywaysecret"
		{
			if obj_player.character == "SP"
				musplay = mu_wafflesecret;
			else if obj_player.character == "PP"
				musplay = mu_entrancesecretPP_SP;
			else
				musplay = mu_entrancesecret_SP;
		}
		if string_letters(roomname) == "cottonsecret"
			musplay = mu_cottonsecret
		if string_letters(roomname) == "molassessecret"
			musplay = mu_swampsecret
		if string_letters(roomname) == "minessecret"
			musplay = mu_minessecret
		if string_letters(roomname) == "dragonlairsecret"
			musplay = mu_dragonlairsecret
		if string_letters(roomname) == "oldfactorysecret" or string_letters(roomname) == "dfactorysecret"
			musplay = mu_factorysecret
		if string_letters(roomname) == "oldfreezersecret"
			musplay = mu_freezersecret
		//if string_letters(roomname) == "watersecret"
		//	musplay = mu_waterlevelsecret
		if string_letters(roomname) == "warsecret"
			musplay = mu_warsecret
		if (string_contains(roomname, "secret") && (obj_player.character == "SP" 
		|| obj_player.character == "SN"))
		{
			musplay = fmod_swap_audio(musplay, global.fmod_ss_replace)
			if musplay == mu_desertsecret_SP && roomnumber > 5
				musplay = mu_desertsecretUFO_SP
			else if musplay == mu_sewersecret_SP && roomnumber > 2
				musplay = mu_sewersecret2_SP
		}
	}	
	
	if (roomname == "room_of_dog")
		musplay = mu_dogsong;
	if (room == rm_pvparena)
	{
		musplay = mu_arenasong
		fadeoff = 0
	}
	else if (room == hub_pvp)
	{
		musplay = mu_arcade1
		fadeoff = 0
	}
	
	if room == hub_race
	{
		musplay = mu_racehub
		fadeoff = 0
	}
}

if musplay != FMOD_EMPTY
{
	// event:/PIZZA CASTLE
	if global.musicgame == 1
		musplay = scr_getmidi(musplay);
	
	// play the song
	if fmod_get_instance_name(global.music) != musplay
	{
		// try to remedy secret song looping main song
		if string_contains(musplay, "secret")
			secretfadeoff = fadeoff;
		else if string_contains(global.music, "secret")
		{
			if fadeoff < secretfadeoff
				fadeoff += round(secretfadeoff / fmod_get_instance_timeline_pos(global.music)) 
				* fmod_get_instance_timeline_pos(global.music);
		}
		scr_sound(musplay,,true, fadeoff % fmod_get_event_length(musplay))
	}
	else if !fmod_is_instance_playing(global.music)
	{
		fmod_play_instance(global.music)
	}
}

if forcefadeoff != -1
{
	fmod_set_instance_timeline_pos(global.music, forcefadeoff);
	forcefadeoff = -1;
}
fmod_set_pitch(global.music, musicpitch);
scr_panictimemusic()
