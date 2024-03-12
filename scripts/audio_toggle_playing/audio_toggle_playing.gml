function audio_toggle_playing(snd){
	if audio_is_paused(snd)
		audio_resume_sound(snd)
	else
		audio_pause_sound(snd)
}