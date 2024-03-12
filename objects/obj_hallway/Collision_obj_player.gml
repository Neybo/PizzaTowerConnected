var hall = id;
var player = other.id;

with player
{
	if !hall.old && !instance_exists(obj_randomsecret)
		x = hall.x
	y = min(y, hall.y + (hall.sprite_height - 46));
	
	if !instance_exists(obj_fadeout) && !instance_exists(obj_pausefadeout) && (!instance_exists(obj_pause) or !obj_pause.pause) && state != states.hit
	{
		targetDoor = hall.targetDoor
		targetRoom = hall.targetRoom
		
		if !hall.old
		{
			hallway = true
			hallwaydirection = hall.image_xscale;
			
			if hall.targetRoom == room && !hall.sameroom
			{
				hallwaydirection *= -1;
				xscale *= -1;
			}
		}
		else
		{
			oldhallway = true
			target_x = other.target_x
			target_y = other.target_y
		}
		
		hall.visited = true
		if state == states.machslide && OLD_GAMEPLAY
			state = states.normal
		
		scr_soundeffect(sfx_door)
		instance_create(x, y, obj_fadeout)
	}
	if instance_exists(obj_pausefadeout)
	{
		x = xprevious;
		y = yprevious;
	}
}

