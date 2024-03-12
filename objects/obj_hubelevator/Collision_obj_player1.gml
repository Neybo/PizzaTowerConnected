if state == 0
{
	with other
	{
		if key_up && grounded && state == states.normal && y = other.y + 50
		{
			fmod_play_instance(stepsnd)
			
			if (character == "A" && array_length(other.hub_array) == 8)
				array_pop(other.hub_array)
				
			doorx = other.x + 50;
			other.state = 1;
		}
	}
}