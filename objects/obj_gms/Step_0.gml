// no internet
if (!gms_info_isloggedin() or !os_is_network_connected())
//&& ((instance_exists(obj_player) && .state != states.titlescreen) or !instance_exists(obj_player))
&& room != Realtitlescreen && room != characterselect
{
	instance_destroy(obj_fadeout);
	instance_destroy(obj_pause);
	instance_destroy(obj_pausefadeout);
	instance_activate_all();
	
	gms_logout();
	alarm[4] = 1;
	
	with obj_player
		alarm[11] = 60;
	exit;
}

// logout if title screen
if gms_info_isloggedin() && room == Realtitlescreen
{
	gms_logout();
	instance_destroy();
}

// gots
if (!instance_exists(obj_pause) or !obj_pause.pause) && global.gottp[0] // tpother
{
	with obj_player
		alarm[11] = 60;
	global.gottp[0] = false;

	// tp normally
	global.gottp[0] = true;
	with obj_player
	{
		scr_playerreset();
		x = global.gottp[1];
		y = global.gottp[2];
		targetDoor = "none";
		
		room_goto_new(global.gottp[3]);
		global.gottp[0] = false;
	}
}
if global.__gotmessage[0] // global message
{
	global.__gotmessage[0] = false;

	scr_soundeffect(sfx_Nspin);
	showmessage = true;
	alarm[2] = 300;
}
depth = -9999;