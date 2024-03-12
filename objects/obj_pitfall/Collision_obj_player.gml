var hallway = id;
with other
{
	x = other.x
	y = other.y + (other.sprite_height - 46) 
	
	if !instance_exists(obj_fadeout)
	{
		with obj_player
		{
			targetDoor = hallway.targetDoor
			targetRoom = hallway.targetRoom
		}
		image_index = 0
		
		instance_create(x, y, obj_fadeout)
	}
}

