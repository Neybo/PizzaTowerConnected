if other.state == states.gameover or !visible
	exit;

if image_index == 0 && (global.panic or room == snick_challengeend)
{
	if instance_exists(obj_gms)
		gms_ini_player_write("saveData", "pizzacoin", scr_getcoin());
	else
	{
		ini_open("saveData" + string(global.saveslot) + ".ini");
		ini_write_real("online", "pizzacoin", scr_getcoin());
		ini_close();
	}
	image_speed = 0.35
	image_index = 0
	
	global.panic = false
	global.snickchallenge = false
	global.snickrematch = false

	instance_destroy(obj_snickexe);
	instance_destroy(obj_snickexf);
	instance_destroy(obj_snickexg);
	instance_destroy(obj_snickexh);
	instance_destroy(obj_snickexi);
	
	//SAGE2019
	if !fmod_is_instance_playing(global.jukebox)
		fmod_stop_instance_immediately(global.music)
	
	hit = true;
	with obj_timeattack
		newalarm = -1;
	with obj_camera
		alarm[1] = -1;
	with obj_pizzaface
		instance_destroy();
	
	if global.timeattack 
		with obj_timeattack
			stop = true;
}