if fmod_is_instance_playing(global.jukebox) || global.musicvolume <= 0
	exit;
	
// music to play
var musplay = FMOD_EMPTY;
	
if !global.panic
	panicfadeoff = 0;

// snick challenge
if global.snickchallenge && !obj_pause.pause && !obj_camera.ded
{
	if global.minutes >= 2
		musplay = global.snickrematch ? mu_snickrematch : mu_snickchallenge;
	else
		musplay = global.snickrematch ? mu_snickrematchend : mu_snickchallengeend;
	if obj_player.character == "PP"
	{
	 	musplay = fmod_swap_audio(musplay, global.fmod_pp_replace)
	}
}

// miniboss music
if global.miniboss
	musplay = mu_miniboss;
else if fmod_get_instance_name(global.music) == mu_miniboss
	fmod_release_instance(global.music);

if musplay != FMOD_EMPTY
{
	// event:/PIZZA CASTLE
	if global.musicgame == 1
		musplay = scr_getmidi(musplay);

	// actually play the song
	if fmod_get_instance_name(global.music) != musplay 
	&& !obj_pause.pause
	{
		fmod_release_instance(global.music);
		scr_sound(musplay);
		if global.panic
			fmod_set_instance_timeline_pos(global.music, panicfadeoff);
	}
}

// last music position
if fmod_is_instance_playing(global.music)
{
	fadeoff = fmod_get_instance_timeline_pos(global.music);
	if global.panic
		panicfadeoff = fmod_get_instance_timeline_pos(global.music);
}
else
	fadeoff = 0;

// pln slowdown
if room == hub_roomPLN && fmod_is_instance_playing(global.music)
{
	fmod_set_pitch(global.music, 0.5);
}