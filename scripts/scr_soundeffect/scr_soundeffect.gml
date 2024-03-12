function scr_soundeffect()
{
	var snd = argument[irandom(argument_count - 1)];
	return scr_soundeffect_ext(snd);
}

function scr_soundeffect_pitch(snd, pitch, docharswap = true)
{
	return scr_soundeffect_ext(snd, false, 1, pitch);
}

function scr_soundeffect_ext(snd, loops = false, vol = 1, pitch = 1, docharswap = true, rel = true)
{
	// old mach sound
	if global.machsound == 1 && snd == sfx_break
		snd = sfx_machslide;
	
	// replace timesup sound
	if snd == mu_timesup && scr_checkskin(checkskin.p_anton)
		snd = mu_antondeath;
	
	// player character specific sounds
	if docharswap && instance_exists(obj_player) 
	{
		if !((snd == sfx_parry or snd == sfx_taunt) && object_index == obj_coolpineapple)
		{
			if obj_player.character == "SP"
			{
				if snd == sfx_parry
					snd = sfx_parrySP;
				if snd == sfx_collecttoppin
					snd = sfx_toppinjingleSP;
				if snd == sfx_collecttopping
					snd = sfx_toppingSP;
			}
			else if obj_player.character == "PP"
			{
				snd = fmod_swap_audio(snd, global.fmod_pp_replace)
			}
		}
	}
	
	var sndplay = fmod_create_instance(snd);
	
	if snd == sfx_collecttopping && FINAL_GAMEPLAY
		pitch = random_range(0.95, 1.05)

	fmod_play_instance(sndplay)
	fmod_set_loop(sndplay, loops)
	fmod_set_pitch(sndplay, pitch)
	fmod_set_vol(sndplay, vol * global.soundvolume, true)
	if rel
		fmod_mark_for_release_instance(sndplay)

	return sndplay;
}