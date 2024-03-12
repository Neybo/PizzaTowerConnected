/// @description disconnected
global.roommessage = lang_string("online.disconnected");
instance_destroy(obj_fadeout);
instance_destroy(obj_pausefadeout);

with obj_player 
{
	scr_playerreset();
	state = states.titlescreen;
	targetDoor = "A";
}

fmod_stop_all();
room_goto(Realtitlescreen);
global.logged = false;
alarm[6] = -1
instance_destroy();

