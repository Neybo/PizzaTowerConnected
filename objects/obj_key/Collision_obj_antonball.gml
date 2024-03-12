with obj_player
{
	instance_destroy(other)
	global.key_inv += 1
	key_particles = true
	alarm[7] = 30
	scr_soundeffect(sfx_collecttoppin)
}

