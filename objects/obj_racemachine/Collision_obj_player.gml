with other
{
	if place_meeting(x, y, other) && key_up && grounded && state == states.normal && check_online()
	{
		instance_create(0,0,obj_racemenu)
	}
}

