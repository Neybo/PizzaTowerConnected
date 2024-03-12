with other
{
	y = min(y, other.y + (other.sprite_height - 46));
	
	if !instance_exists(obj_fadeout) or obj_fadeout.fadein && !instance_exists(obj_pausefadeout) && !obj_pause.pause
	{
		instance_destroy(obj_fadeout)
		targetDoor = other.targetDoor
		targetRoom = other.targetRoom
		
		verticalhallway = true
		vhallwaydirection = other.image_yscale
		
		vhallwaypos = x - other.x
		vhallwaypos /= other.sprite_width
		
		if other.targetRoom == room
		{
			vhallwaydirection *= -1;
			vsp *= -1;
			
			if state == states.Sjump
				state = states.normal;
		}
		
		other.visited = true
		
		scr_soundeffect(sfx_door)
		instance_create(x, y, obj_fadeout)
	}
	if instance_exists(obj_pausefadeout)
	{
		x = xprevious;
		y = yprevious;
	}
}

