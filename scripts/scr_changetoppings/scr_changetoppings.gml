function scr_changetoppings()
{
	with obj_global
		event_user(0);
	with obj_collect
	{
		var spr = scr_collectsprite();
		if spr != sprite_index
		{
			sprite_index = spr;
			instance_create(x + sprite_width / 2, y + sprite_height / 2, obj_cloudeffect);
		}
	}
}

