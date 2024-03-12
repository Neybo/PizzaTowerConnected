var player = instance_place(x, y - 1, obj_player);
if player
{
	with player
	{
		if state != states.gameover && state != states.hitlag
		{
			if state == states.knightpep
				state = states.knightpepslopes
			else if state != states.knightpepslopes
			{
				sprite_index = spr_slipnslide
				state = states.slipnslide
			}
			if movespeed < 12
				movespeed = 12
		}
	}
}

