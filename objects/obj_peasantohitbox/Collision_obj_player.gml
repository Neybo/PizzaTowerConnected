if place_meeting(x, y, obj_parryhitbox)
	exit;

with other
{
	if character == "V"
		scr_hurtplayer(id)
	else if state != states.gameover && state != states.rideweenie && state != states.hitlag
	{
		scr_transfobump(false);
		
		gp_vibration(1, 1, 0.85)
		state = states.fireass
		vsp = -25
		sprite_index = spr_fireass
		image_index = 0
		
		if !fmod_is_instance_playing(snd_fireass) 
		or fmod_get_instance_timeline_pos(snd_fireass) >= 5000
		{
			fmod_stop_instance_immediately(snd_fireass);
			fmod_play_instance(snd_fireass);
		}
	}
}

