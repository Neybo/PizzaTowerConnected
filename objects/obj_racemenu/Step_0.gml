if menu == racestates.created
{
	if gms_session_player_count(gms_session_current_id()) >= maxplayer
	{
		if keyboard_check_pressed(vk_enter)
			event_user(0);
	}
	if lastplayer != gms_session_player_count(gms_session_current_id())
	{
		event_user(1)
		lastplayer = gms_session_player_count(gms_session_current_id())
		if (gms_session_player_count(gms_session_current_id()) >= maxplayer)
			alarm[2] = ((300 - (30 * (lastplayer - 2))) * 60) + ((lastplayer == 12) ? 10 : 0) 
			// 5 minutes, - 30 seconds for extra user over 2, + 10 secs for 12 people
		else
			alarm[2] = -1
	}
}

if startrace
{
	instance_activate_all();
	instance_activate_all();
	instance_activate_all();
	startrace = false;
	event_user(6)
	menu = -1;
}

if destroythis
{
	menu = -1
	
	instance_activate_all();
	
	while instance_exists(self)
		instance_destroy(self)
}