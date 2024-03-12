if !instance_exists(obj_fadeout) && other.state != states.gameover && !other.cutscene && !other.godmode
{
	if !fmod_is_instance_playing(global.jukebox)
		fmod_stop_all();
	
	scr_playerreset();
	global.combo = 0
	global.combotime = 0
	global.panic = false
	with obj_player
	{
		c = 0;
		state = states.comingoutdoor;
		targetDoor = "A";
	}
	room_goto(grinch_1);
}

