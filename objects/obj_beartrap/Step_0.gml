if press >= 8 && !drop
{
	with playerid
	{
		image_index = 0
		alarm[8] = 60
		state = states.hurt
	}
	drop = true
	closed = false
	
	vsp = -5;
	hsp = playerid.xscale * -5;
}

if closed && instance_exists(playerid)
	y = playerid.y
else if drop
{
	x += hsp;
	y += vsp;
	
	if vsp < 20
		vsp += grav;
}
else
	scr_collide();
