function scr_sound(mus, loop = true, this_is_music = false, fadeoff = 0)
{
	/*// repainted
	if instance_exists(obj_player)
	{
		if obj_player.character == "PP"
		{
			if asset_get_type(audio_get_name(mus) + "_PP") == asset_sound
				mus = asset_get_index(audio_get_name(mus) + "_PP");
		}
	}*/
	var oldmus = global.music
	global.music = fmod_create_instance(mus)//audio_play_sound(mus, 1, loop);
	fmod_set_loop(global.music, loop)
	
	if oldmus != FMOD_EMPTY
	{
		if fmod_play_instance(global.music) == FMOD_RESULT.FMOD_OK
		{
			var currentt = current_time
			do  // this is so stupid :)
			{
				if fmod_update() != FMOD_RESULT.FMOD_OK
				|| current_time - currentt > 1000 // prevent infinite loop :)
					break;
			}
			until (fmod_get_instance_playback_state(global.music) == 
			FMOD_STUDIO_PLAYBACK_STATE.FMOD_STUDIO_PLAYBACK_PLAYING)
			fmod_stop_instance(oldmus)
			fmod_mark_for_release_instance(oldmus)
			if this_is_music
					fmod_set_instance_timeline_pos(global.music, fadeoff)
		}
		else
			return oldmus
	}
	else
	{
		var currentt = current_time
		do  // this is so stupid :)
		{
			if fmod_update() != FMOD_RESULT.FMOD_OK
			|| current_time - currentt > 1000 // prevent infinite loop :)
				break;
		}
		until (fmod_get_instance_playback_state(global.music) == 
		FMOD_STUDIO_PLAYBACK_STATE.FMOD_STUDIO_PLAYBACK_PLAYING)
	}
	if room != rm_disclaimer
		fmod_set_vol(global.music, global.musicvolume);
	
	return global.music;
}

