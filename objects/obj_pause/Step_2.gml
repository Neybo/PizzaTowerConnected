if check_online()
	gms_self_set("pause", pause);

if instance_exists(obj_pausefadeout) && (instance_exists(obj_fadeout) or !canpause)
	instance_destroy(obj_pausefadeout);


// start pausing
if !pause && !instance_exists(obj_fadeout) && !instance_exists(obj_pausefadeout) && !global.racing
{
	var kstart = false;
	if instance_exists(obj_player)
		kstart = obj_player.key_start;
	else
	{
		scr_getinput();
		kstart = key_start;
	}
	
	// pressed pause button
	if kstart && (room != rank_room && room != Realtitlescreen && room != timesuproom && room != characterselect)
	{
		keyboard_clear(global.key_jump);
		
		if !check_race() && (!instance_exists(obj_player) 
		or (obj_player.state != states.grabbed && obj_player.baddiegrabbedID != obj_otherplayer))
		{
			selected = 0;
			objectlist = [];
			if instance_exists(obj_gms)
			{
				global.minichatstore = global.minichat
				global.minichat = false;
			}
			event_user(1)
			if fmod_is_instance_playing(global.music) && global.jukebox == global.music
			{
				maxselect = 5;
			}
			else
				maxselect = 4
		}
		else
			scr_soundeffect(sfx_denied);
	}
}

if pause && !instance_exists(obj_option)
{
	if !string_startswith(konami, "UUDDLRLR")
		scr_getinput();
	//DDP Always draw normally while paused
	application_surface_draw_enable(true)
	if instance_exists(obj_pausefadeout) && !obj_pausefadeout.fadein
		exit;
		
	
	// move
	if key_down2 && selected < maxselect
	{
		selected += 1
		scr_soundeffect(sfx_step)
	}

	if key_up2 && selected > 0
	{
		selected -= 1
		scr_soundeffect(sfx_step)
	}
	
	// RESTART LEVEL
	if key_jump && selected == 1
	{
		if global.leveltosave != "none"
		{
			if !global.snickchallenge
			{
				gotoroom = hub_room1;
				switch (global.leveltosave)
				{
					case "entrance":
						gotoroom = entrance_1;
						break;
					case "medieval":
						gotoroom = medieval_1;
						break;
					case "chateau":
						gotoroom = chateau_1;
						break;
					case "ruin":
						gotoroom = ruin_1;
						break;
					case "dungeon":
						gotoroom = dungeon_1;
						break;
					case "desert":
						gotoroom = floor1_room0;
						break;
					case "mansion":
						gotoroom = oldmansion_9;
						break;
					case "factory":
						gotoroom = oldfactory_0;
						break;
					case "sewer":
						gotoroom = oldsewer_0;
						break;
					case "freezer":
						gotoroom = oldfreezer_1;
						break;
					case "golf":
						gotoroom = golf_1;
						break;
					case "graveyard":
						gotoroom = graveyard_1;
						break;
					case "farm":
						gotoroom = farm_1;
						break;
					case "ufo":
						gotoroom = ufo_1;
						break;
					case "dragonlair":
						gotoroom = dragonlair_1;
						break;
					case "strongcold":
						gotoroom = strongcold_10;
						break;
					case "beach":
						gotoroom = beach_1;
						break;
					case "forest":
						gotoroom = forest_1;
						break;
					case "kungfu":
						gotoroom = kungfu_1;
						break;
					case "war":
						gotoroom = war_1;
						break;
					case "space":
						gotoroom = space_1;
						break;
					case "etb":
						gotoroom = etb_1;
						break;
					case "ancient":
						gotoroom = ancient_1;
						break;
					case "grinch":
						gotoroom = grinch_1;
						break;
					case "entryway":
						gotoroom = entryway_1;
						break;
					case "cotton":
						gotoroom = cotton_1;
						break;
					case "molasses":
						gotoroom = molasses_1;
						break;
					case "d2factorybase":
						gotoroom = d2factorybase_1;
						break;
					case "d2ancientbase":
						gotoroom = d2ancientbase_1;
						break;
					case "d2factory":
						gotoroom = d2factory_1;
						break;
					case "tower": 
						if global.panic
							gotoroom = tower_finalhallway;
						else
							gotoroom = tower_1
						break;
					case "secrets":
						gotoroom = secret_entrance;
						break;
					case "saloon":
						gotoroom = saloon_1;
					case "top":
						gotoroom = exit_1;
					case "finalruin":
						gotoroom = FINALruin_1;
					case "finaldungeon":
						gotoroom = FINALdungeon_1;
					case "finalentrance":
						gotoroom = FINALentrance_1;
					//case "finalmedieval":
					//	gotoroom = FINALmedieval_1;
						break;
				}
			
				if gotoroom != -1
				{
					instance_activate_all();
					alarm[0] = 1;
				}
				else
					scr_soundeffect(sfx_enemyprojectile);
			}
			else if global.snickchallenge or global.snickrematch
			{
				instance_activate_all();
				alarm[2] = 1;
			}
		}
		else
			scr_soundeffect(sfx_denied);
	}
	
	// OPTIONS
	if key_jump && selected == 4 && !instance_exists(obj_option)
	{
		scr_soundeffect(sfx_step);
		with instance_create(0, 0, obj_option)
		{
			if global.jukebox != FMOD_EMPTY
			{
				fmod_resume_instance(global.jukebox);
				music = global.jukebox;
			}
			else if global.musicvolume > 0
			{
				music = scr_soundeffect_ext(mu_editor, true);
				fmod_set_vol(music, global.musicvolume);
			}
		}
	}
	
	// CLEAR JUKEBOX
	if key_jump && selected == 5
	{
		selected = 4
		maxselect = 4
		jukeboxused = true
		fmod_release_instance(global.jukebox)
		global.jukebox = FMOD_EMPTY;
		global.music = FMOD_EMPTY;
		scr_soundeffect(sfx_step)
	}
	// EXIT LEVEL
	if key_jump && selected == 2
	{
		instance_activate_all();
		alarm[1] = 1;
	}
	// EXIT TO TITLE
	if key_jump && selected == 3
	{
		instance_activate_all();
		alarm[3] = 1;
	}
	
	// RESUME
	if key_jump && selected == 0
	{
		if !instance_exists(obj_pausefadeout)
			instance_create(x, y, obj_pausefadeout);
	}
	
	// konami code for old golf level funmode
	if alarm[0] == -1 && alarm[1] == -1 && alarm[2] == -1 && !global.funmode 
	&& global.leveltosave == "golf" && !global.timeattack
	{
		switch keyboard_lastkey
		{
			case vk_up:
				konami += "U";
				break;
			case vk_down:
				konami += "D";
				break;
			case vk_left:
				konami += "L";
				break;
			case vk_right:
				konami += "R";
				break;
			case global.key_jump:
				konami += "A";
				break;
			case global.key_slap:
				konami += "B";
				break;
		}
		if konami != "" && string_copy(konamiend, 1, string_length(konami)) != konami
			konami = "";
		
		if konami == konamiend
		{
			global.funmode = true;
			scr_soundeffect(sfx_collecttoppin);
			keyboard_clear(keyboard_lastkey);
			instance_create(x, y, obj_pausefadeout)
			konami = "";
			unlock_hat(HATS.scatman)
		}
		keyboard_lastkey = -1;
	}
}
else
	konami = "";
