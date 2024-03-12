if room != room_of_dog
{
	room = room_of_dog
	instance_destroy();
	exit;
}

application_surface_draw_enable(true);
fmod_release_all();
with all
	if id != other.id && object_index != obj_fmod instance_destroy(id, false);
scr_soundeffect(sfx_wawa);

surf = surface_create(100, 100);

var inst = FMOD_EMPTY

if (global.musicgame == 1)
	inst = fmod_create_instance(scr_getmidi(mu_dogsong))
else
	inst = fmod_create_instance(mu_dogsong)
fmod_set_loop(inst, true)
fmod_play_instance(inst)
	
alarm[0] = -1