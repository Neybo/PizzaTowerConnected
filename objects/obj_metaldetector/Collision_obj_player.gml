with other
{
	if shotgunAnim
	{
		shotgunAnim = false
		with instance_create(x, y, obj_sausageman_dead)
		{
			if other.character == "N"
				sprite_index = spr_minigunfall
			else if other.character == "PP"
				sprite_index = spr_coconutgunfall
			else if other.character == "SP"
				sprite_index = spr_canecollect
			else
				sprite_index = spr_shotgunback
			image_speed = 0;
		}
		
		if sprite_index == spr_shotgunsuplexdash
			sprite_index = spr_suplexdash;
	}
}

