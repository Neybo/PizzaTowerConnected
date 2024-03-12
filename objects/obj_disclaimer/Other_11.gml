/// @description con 0
con = 0;
fmod_stop_all();

scr_soundeffect(sfx_diagopen);
song = scr_sound(mu_dungeondepth);
fmod_set_pitch(song, 0.25);
alarm[3] = 10