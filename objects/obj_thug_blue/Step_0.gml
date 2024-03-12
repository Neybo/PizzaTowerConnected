event_inherited();

var player = instance_nearest(x, y, obj_player);
if OLD_GAMEPLAY && instance_exists(player) && (state == states.walk or state == states.chase)
{
	if player.x > x - 400 && player.x < x + 400
	&& player.y <= y + 60 && player.y >= y - 60
	{
		if state != states.pizzagoblinthrow && bombreset <= 0
		{
			shot = false;
			state = states.pizzagoblinthrow
			sprite_index = spr_shrimp_knife
				
			if player.x != x
				image_xscale = -sign(x - player.x);
				
			image_index = 0;
			flash = true;
		}
	}
}

