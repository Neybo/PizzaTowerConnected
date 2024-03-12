if respawn > 0
{
	respawn--
	if respawn <= 0
	{
		visible = true
		sprite_index = spr_balloon
		x = xstart
		y = ystart
	}
	else if respawn == 12 && REMIX_GAMEPLAY
	{
		visible = true
		sprite_index = spr_balloonappear
		image_index = 0
	}
}

