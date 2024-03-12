/// @description exit
fmod_stop_all();
instance_activate_all();
with obj_player
{
	backtohubstartx = x
	backtohubstarty = y
}
alarm[0] = 1;