with other
{
	if state != states.Sjump
	{
		scr_transfobump(false);
		if state == states.bombpep
			instance_create(x, y, obj_bombexplosion)
		
		x = other.x
		if scr_solid(x, y)
			x = xprevious;
		
		instance_create(x, y - 20, obj_bangeffect);
		
		fmod_stop_instance_immediately(superjumpreleasesnd)
		superjumpreleasesnd = scr_soundeffect(sfx_superjumprelease)
		sprite_index = spr_superspringplayer
		if state != states.titlescreen	
			state = states.Sjump
		springsjump = true
		vsp = -10
		
		other.image_index = 0
		other.sprite_index = spr_presentbox_activate
	}
}
