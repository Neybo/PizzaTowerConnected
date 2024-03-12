//Scared
var p = instance_nearest(x, y, obj_player);
if !p
	exit; // uh oh!

if p.x > x - 400 && p.x < x + 400 && sprite_index != spr_angry
	sprite_index = spr_angry
else if !(p.x > x - 400 && p.x < x + 400) && sprite_index == spr_angry
{
	sprite_index = spr_happy
	alarm[0] = 100
}

if place_meeting(x, y, obj_otherplayer)
	image_alpha = 0.5;
else
	image_alpha = 1;

// fade meatophobia
if global.musicvolume > 0 && global.jukebox == FMOD_EMPTY
{
	if song != FMOD_EMPTY 
	&& fmod_is_instance_playing(song)
	{
		if global.panic
		{
			fmod_release_instance(song);
			song = FMOD_EMPTY;
		}
		else
		{
			if fmod_get_instance_playback_state(song) == FMOD_STUDIO_PLAYBACK_STATE.FMOD_STUDIO_PLAYBACK_SUSTAINING
				fmod_resume_instance(song);
			
			var vol = 1;
			if FINAL_GAMEPLAY
				vol = clamp((1 - (point_distance(x, y, p.x, p.y) / 300)) + 1, 0, 1);
				
			var mv = global.musicvolume;
			fmod_set_vol(song, vol * mv, false);
			fmod_set_vol(global.music, mv - (vol * mv), false);
		}
	}
	else if !global.panic
	{
		fmod_release_instance(song);
		song = FMOD_EMPTY;
	
		if ((room != dungeon_10 && !string_startswith(room_get_name(room), "dragonlair"))
		or scr_checkskin(checkskin.p_anton))
		{
			var snd = mu_dungeondepth
			if global.musicgame == 1
				snd = mu_dungeondepth_pc
			else if scr_checkskin(checkskin.p_anton)
				snd = mu_antondepth
			else if check_sugary()
				snd = mu_gummyharry
			else if global.snickrematch
				snd = mu_dungeondepth_re
			
			song = scr_soundeffect_ext(snd, true,,,,false);
			fmod_set_vol(song, 0);
		}
	}
}

