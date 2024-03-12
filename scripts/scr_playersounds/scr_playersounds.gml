function scr_playersounds()
{
	if state == states.hitlag
		exit;
	
	var _sfx_tumble3 = (global.machsound == 1 && sprite_index == spr_machroll) ? 
	tumble3alt : tumble3snd;

	
	// mach1 sound
	if state == states.mach1 && grounded
	{
		if !fmod_is_instance_playing(_sfx_mach1)
			fmod_play_instance(_sfx_mach1);
	}
	else
		fmod_stop_instance_immediately(_sfx_mach1);
		
	// mach2 sound
	if (sprite_index == spr_mach or sprite_index == spr_player_machhit or state == states.climbwall
	or (sprite_index == spr_rollgetup && image_index >= 8))
	&& state != states.backbreaker
	{
		if !fmod_is_instance_playing(_sfx_mach2)
			fmod_play_instance(_sfx_mach2);
	}
	else
		fmod_stop_instance_immediately(_sfx_mach2);
		
	// mach3 sound
	if (state == states.mach3 or sprite_index == spr_mach3boost) && sprite_index != spr_crazyrun
	&& state != states.backbreaker
	{
		if !fmod_is_instance_playing(_sfx_mach3)
			fmod_play_instance(_sfx_mach3);
	}
	else
		fmod_stop_instance_immediately(_sfx_mach3);
		
	// knightpep slope
	if state == states.knightpepslopes && grounded
	{
		if !fmod_is_instance_playing(knightslide)
			fmod_play_instance(knightslide);
	}
	else
		fmod_stop_instance_immediately(knightslide)
		
	// bombpep
	if (sprite_index == spr_bombpeprun or sprite_index == spr_bombpeprunabouttoexplode)
	&& state != states.backbreaker
	{
		if !fmod_is_instance_playing(bombpep1snd)
			fmod_play_instance(bombpep1snd)
	}
	else
		fmod_stop_instance_immediately(bombpep1snd)
		
	// mach4
	if sprite_index == spr_crazyrun && state != states.backbreaker
	{
		if !fmod_is_instance_playing(_sfx_mach4)
			fmod_play_instance(_sfx_mach4)
	}
	else
		fmod_stop_instance_immediately(_sfx_mach4)
		
	// sjump hold
	if state != states.Sjumpprep && fmod_is_instance_playing(superjumpholdsnd)
		fmod_stop_instance_immediately(superjumpholdsnd)
		
	// tumble starting
	if sprite_index == spr_tumblestart && !fmod_is_instance_playing(tumble1snd) 
	&& floor(image_index) < 11
		fmod_play_instance(tumble1snd)
		
	// tumble start
	if sprite_index == spr_tumblestart && floor(image_index) >= 11 
	&& !fmod_is_instance_playing(tumble2snd)
	{
		fmod_play_instance(tumble2snd)
		fmod_stop_instance_immediately(tumble1snd)
	}
		
	// tumbling
	if (sprite_index == spr_tumble or sprite_index == spr_machroll) 
	&& !fmod_is_instance_playing(_sfx_tumble3) 
		fmod_play_instance(_sfx_tumble3)
		
	// stop tumbling sounds
	if state != states.tumble && (sprite_index != spr_machroll or state == states.backbreaker)
	{
		fmod_stop_instance_immediately(tumble1snd)
		fmod_stop_instance_immediately(tumble2snd)
		fmod_stop_instance_immediately(tumble3snd)
		fmod_stop_instance_immediately(tumble3alt)
	}
		
	// stop suplex dash sound
	if state != states.handstandjump && state != states.punch && fmod_is_instance_playing(suplexdashsnd) 
		fmod_stop_instance_immediately(suplexdashsnd)
		
	// bitch sound
	if sprite_index == spr_mach2jump && character == "SP" && FINAL_GAMEPLAY
	{
		if !fmod_is_instance_playing(flipsnd)
			fmod_play_instance(flipsnd)
	}
	else
		fmod_stop_instance_immediately(flipsnd)
}

function scr_playersounds_refresh()
{
	fmod_release_instance(knightslide)
	
	fmod_release_instance(tumble1snd)
	fmod_release_instance(tumble2snd)
	fmod_release_instance(tumble3snd)
	fmod_release_instance(tumble3alt)
	
	fmod_release_instance(superjumpholdsnd)
	fmod_release_instance(suplexdashsnd)
	fmod_release_instance(flipsnd)
	
	fmod_release_instance(_sfx_mach1)
	fmod_release_instance(_sfx_mach2)
	fmod_release_instance(_sfx_mach3)
	fmod_release_instance(_sfx_mach4)
	
	fmod_release_instance(snd_fireass)
	
	knightslide = fmod_create_instance(character == "PP" ? sfx_knightslide_PP : sfx_knightslide)
	bombpep1snd = fmod_create_instance(sfx_bombpep1)
	
	tumble1snd = fmod_create_instance(character == "PP" ? sfx_tumble1_PP : sfx_tumble1)
	tumble2snd = fmod_create_instance(character == "PP" ? sfx_tumble2_PP : sfx_tumble2)
	
	tumble3snd = fmod_create_instance(character == "PP" ? sfx_tumble3_PP : sfx_tumble3)
	tumble3alt = fmod_create_instance(sfx_machroll)
	
	fmod_set_loop(tumble3snd, true)
	fmod_set_loop(tumble3alt, true)
	
	superjumpholdsnd = fmod_create_instance(character == "PP" ? sfx_superjumphold_PP : sfx_superjumphold)
	suplexdashsnd = fmod_create_instance(character == "PP" ? sfx_suplexdash_PP : sfx_suplexdash)
	flipsnd = fmod_create_instance(sfx_flip_ss)
	
	snd_fireass = fmod_create_instance(character == "PP" ? sfx_scream5_PP :
	(check_sugary(,true) ? sfx_screamSP : sfx_scream5))
	
	// set mach sounds
	var __sfx_mach1 = global.machsound == 0 ? sfx_mach1 : sfx_mach1_old
	var __sfx_mach2 = global.machsound == 0 ? sfx_mach2 : sfx_mach2_old
	var __sfx_mach3 = global.machsound == 0 ? sfx_mach3 : sfx_mach3_old
	var __sfx_mach4 = global.machsound == 0 ? sfx_mach4 : sfx_mach3_old
	
	_sfx_mach1 = fmod_create_instance(fmod_swap_audio_pp(__sfx_mach1, character));
	if instance_exists(obj_option) // small bs
		_sfx_mach2 = fmod_create_instance(__sfx_mach2);
	else // fix this later, 
		_sfx_mach2 = fmod_create_instance(fmod_swap_audio_pp(__sfx_mach2, character));
	_sfx_mach3 = fmod_create_instance(fmod_swap_audio_pp(__sfx_mach3, character));
	_sfx_mach4 = fmod_create_instance(fmod_swap_audio_pp(__sfx_mach4, character));
	
	_sfx_step = character == "PP" ? sfx_step_new_PP : sfx_step
	
	// cheat snds
	tauntsnd = FMOD_EMPTY
	superjumpreleasesnd = FMOD_EMPTY
	groundpoundsnd = FMOD_EMPTY
	sjumpprepsnd = FMOD_EMPTY
	
	fmod_set_vol(knightslide, global.soundvolume, true)
	fmod_set_vol(bombpep1snd, global.soundvolume, true)
	
	fmod_set_vol(tumble1snd, global.soundvolume, true)
	fmod_set_vol(tumble2snd, global.soundvolume, true)
	fmod_set_vol(tumble3snd, global.soundvolume, true)
	fmod_set_vol(tumble3alt, global.soundvolume, true)
	
	fmod_set_vol(superjumpholdsnd, global.soundvolume, true)
	fmod_set_vol(suplexdashsnd, global.soundvolume, true)
	fmod_set_vol(flipsnd, global.soundvolume, true)
	fmod_set_vol(snd_fireass, global.soundvolume, true)
	
	fmod_set_vol(_sfx_mach1, global.soundvolume, true)
	fmod_set_vol(_sfx_mach2, global.soundvolume, true)
	fmod_set_vol(_sfx_mach3, global.soundvolume, true)
	fmod_set_vol(_sfx_mach4, global.soundvolume, true)
}