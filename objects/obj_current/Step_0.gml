with instance_place(x, y - 1, obj_player)
{
	scr_transfobump(false);
	
	if state != states.titlescreen	
		state = states.slipnslide
	xscale = sign(other.image_xscale)
	movespeed = 16
	
	sprite_index = spr_Current
}

with obj_baddie
{
	if place_meeting(x, y + 1, other)
	{
		hsp = sign(other.image_xscale) * 16;
		if stunnable
		{
			stunned = 200
			state = states.stun
			
			if (!variable_instance_exists(id, "watereffect") or !instance_exists(watereffect))
			&& grounded
			{
				with instance_create(x, y, obj_balloonpop)
				{
					image_xscale = other.image_xscale;
					sprite_index = spr_watereffect;
				}
			}
		}
		else
			instance_destroy();
	}
}

with obj_pizzacoin
{
	if place_meeting(x, y + 1, other)
		hsp = 16 * sign(other.image_xscale);
}