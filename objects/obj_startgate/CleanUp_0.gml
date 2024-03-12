with obj_tv
	manualhide = false
fmod_set_pitch(global.music, 1);

if variable_instance_exists(id, "bgmask_surface")
	surf_free(bgmask_surface)
if variable_instance_exists(id, "bgclip_surface")
	surf_free(bgclip_surface)