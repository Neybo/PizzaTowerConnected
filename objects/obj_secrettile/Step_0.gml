var player = instance_place(x, y, obj_player);
if player
{
	if !oneway
	{
		if ds_list_find_index(global.saveroom, id) == -1
		{
			if global.gameplay = 0
				{
					if !done
					{
						scr_soundeffect(sfx_secretwall);
					}
				}
			ds_list_add(global.saveroom, id);
		}
		alpha = Approach(alpha, 0, 0.05);
	}
}
else if alpha < 1
{
	alpha = Approach(alpha, 1, 0.05);
	if alpha >= 1 && oneway && !done
	{
		with instance_create(x, y, obj_solid)
		{
			image_xscale = other.image_xscale;
			image_yscale = other.image_yscale;
		}
		done = true;
		
		for(var i = 0; i < array_length(mylayers); i++)
		{
			var mylayer = mylayers[i];
			if layer_exists(mylayer)
				layer_depth(mylayer, desireddepth - i);
		}
	}
}
