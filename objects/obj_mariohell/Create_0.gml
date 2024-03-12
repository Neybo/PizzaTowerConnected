fmod_stop_instance_immediately(global.music);
depth = -9999;

yourname = environment_get_variable("USERNAME");
if check_online()
{
	yourname = gms_self_name();
	gms_logout();
	
	instance_destroy(obj_gms);
	instance_destroy(obj_otherplayer);
}

alarm[0] = room_speed * 3;
con = 0;
