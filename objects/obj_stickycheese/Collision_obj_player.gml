with (other)
{
	if (vsp < 0)
	{
		repeat (2)
			instance_create(x, y + 43, obj_cheesedebris)
		vsp *= 0.5;
		scr_soundeffect(sfx_cheesejump)
	}
	if (state == states.climbwall)
		state = grounded ? states.normal : states.jump;
	if (hsp != 0 && (floor(image_index) % 4) == 0)
	{
		instance_create(x, y + 43, obj_cheesedebris)
		if (!other.stepped)
		{
			scr_soundeffect(sfx_cheesefloor)
			other.stepped = true;
			other.alarm[0] = 8;
		}
	}
}
