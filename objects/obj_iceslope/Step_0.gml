if place_meeting(x,y-1,obj_player)
with obj_player
{
	if state != states.gameover
	{
		if state != states.knightpep && state != states.knightpepslopes
		{
			state = states.slipnslide
			sprite_index = spr_slipnslide
		}
		if movespeed < 12
			movespeed = 12
		xscale = other.image_xscale;
	}
}