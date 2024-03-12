if newalarm > 0
{
	if obj_player.state != states.hitlag
		newalarm--;
}
else if newalarm > -1
{
	var paused = false;
	if instance_exists(obj_pause)
		paused = obj_pause.pause;
	
	if !stop && !paused
	{
		global.taseconds += 1;
		while global.taseconds >= 60
		{
			global.taseconds -= 60;
			global.taminutes += 1;
		}
		if global.racing
		{
			if (global.taminutes >= global.racelimit)
			{
				gms_p2p_send(p2p.race_finished, gms_p2p_all_in_session, "N/A")
				room_goto(racing_results)
				room = racing_results
				instance_destroy();
				exit;
			}
		}
	}
	newalarm = 60
}