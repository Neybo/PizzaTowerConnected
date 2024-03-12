var piss = false;
with obj_player
	if character == "PP" piss = true;

if diag != noone && !instance_exists(diag)
{
	if !piss
	{
		con = 0;
		fmod_set_vol(global.music, global.musicvolume, false);
	
		diag = noone;
		with obj_player
			state = states.normal;
	}
	else if con == 2 && alarm[0] == -1
	{
		alarm[0] = 60;
	}
}

if con == 1
{
	con = 2;
	
	diag = instance_create(0, 0, obj_dialoguebox);
	if !piss
	{
		with diag
		{
			canskip = false;
			dialogue = [
				lang_str("dialogue.arcade.0"),
				lang_str("dialogue.arcade.1"),
				lang_str("dialogue.arcade.2")
			]
		}
	}
	else
	{
		with diag
		{
			canskip = false;
			diagsound = [sfx_mariotalk1, sfx_mariotalk2, sfx_mariotalk3, sfx_mariotalk4, sfx_mariotalk5];
			rate = 10;
			dialogue = [
				lang_str("dialogue.arcade.3")
			]
		}
	}
}

if con == 3
{
	with obj_player
	{
		state = states.actor;
		sprite_index = spr_idle;
		image_speed = 0.35;
		xscale = -1;
	}
	with obj_camera
		panto = [-150, 0];
	con = 4;
	alarm[0] = 120;
}
if con == 5
{
	if !instance_exists(obj_mariologgedin)
	{
		image_index = 0;
		with instance_create(obj_player.x + 320, obj_player.y, obj_mariologgedin)
		{
			image_xscale = -1;
			hsp = -16;
		}
	}
	with obj_player
	{
		sprite_index = spr_bossintro;
		xscale = 1;
		
		if place_meeting(x, y, obj_mariologgedin)
		{
			ini_open("saveData.ini");
			ini_write_real("online", "mario", true);
			ini_close();
			
			fmod_stop_all();
			scr_playerreset();
			targetDoor = "A";
			room_goto(hub_room1);
		}
	}
}

/*
if debug && keyboard_check_pressed(ord("R"))
{
	instance_destroy(obj_mariologgedin);
	con = 0;
	alarm[0] = -1;
	with obj_camera
		panto = [0, 0];
	with obj_player
		state = states.normal;
}
*/

