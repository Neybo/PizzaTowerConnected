if ds_list_find_index(global.saveroom, id) == -1 && global.panic
{
	var rep = OLD_GAMEPLAY ? 6 : 4;
	for(var i = 0; i <= rep; i++)
	{
		if OLD_GAMEPLAY
		{
			var xx = sprite_width / 2;
			var yy = sprite_height / 2;
		}
		else
		{
			xx = random(sprite_width / 2) + sprite_width / 4;
			yy = random(sprite_height / 2) + sprite_height / 4;
		}
		with instance_create(x + xx, y + yy, obj_debris)
		{
			image_xscale = abs(other.image_xscale)
			image_yscale = abs(other.image_yscale)
			
			if other.sprite_index == spr_bigdestroyableescape_ss
				sprite_index = spr_bigdebrisescape_ss
			else if other.sprite_index == spr_bigdestroyableescapeNEW_ss
				sprite_index = spr_bigdebrisescapeNEW_ss
			else
				sprite_index = spr_bigdebrisescape
			
			image_index = random(image_number)
			momentum = other.momentum
		}
	}
	
	scr_soundeffect(sfx_breakblock)
	ds_list_add(global.saveroom, id) 
}
