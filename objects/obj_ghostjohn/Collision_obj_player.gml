if (state != 1 &&  state != 2 && other.state != states.door && other.state != states.actor && other.state != states.comingoutdoor)
{
	
	with (other)
	{
		hitX = x;
		hitY = y;
		if state == states.mach2 or state == states.mach3
            state = states.normal
		cutscene = true
		sprite_index = spr_hurt;
		image_speed = 0.35;
		vsp = 0
		hsp = 0
	}
	fadein = false;
	state = 1;
	playerid = other.id;
}
