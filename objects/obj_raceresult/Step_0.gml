if (global.racing && lastplayerracing < gms_session_player_count(gms_session_current_id()))
	{
		scr_gms_p2p(p2p.race_info, gms_p2p_all_in_session, "cur-racing")
	}
	else if (global.racing && lastplayerracing > gms_session_player_count(gms_session_current_id()))
	{
		lastplayerracing = gms_session_player_count(gms_session_current_id())
	}
if (!instance_exists(obj_chatexister))
	instance_create(0,0, obj_chatexister)