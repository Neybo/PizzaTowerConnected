with other
{
	if state != states.Sjump
	{
		scr_transfobump(false);
		
		fmod_stop_instance_immediately(superjumpreleasesnd)
		superjumpreleasesnd = scr_soundeffect(sfx_superjumprelease)
		sprite_index = spr_superjump
		state = states.Sjump
		vsp = -15
		other.image_index = 0
		other.image_speed = 0.35
		
		x = other.x + (other.sprite_width / 2)
		if scr_solid(x, y)
			x = xprevious;
		
		image_speed = 0.5
		image_index = 0
		
		springsjump = true;
	}
}

