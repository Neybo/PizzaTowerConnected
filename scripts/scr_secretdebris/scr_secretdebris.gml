function scr_secretdebris(debris = true, blend = c_white, sprite = -1, lay_ids = ["Tiles_1", "Tiles_2"])
{
	var diddebris = false;
	
	var hspapply = [0, 0];
	if variable_instance_exists(id, "momentum")
		hspapply = momentum;
	

		while array_length(lay_ids) > 0
		{
			var lay_id = get_layer(array_pop(lay_ids));
			if lay_id != -1
			{
				var map_id = layer_tilemap_get_id(lay_id);
				if map_id != -1
				{
					var data = tilemap_get_at_pixel(map_id, x, y);
					if data != -1 && data != 0
					{
						tilemap_set_at_pixel(map_id, tile_set_empty(data), x, y);
						if debris
						{
							repeat 4
							{
								with instance_create(x + sprite_width / 2, y + sprite_height / 2, obj_secretdebris)
								{
									sprite_index = sprite_exists(sprite) ? sprite : spr_secretdebris;
									tile_dataid = data;
									tile_dataset = tilemap_get_tileset(map_id);
									momentum = hspapply;
								}
							}
							diddebris = true;
						}
					}
				}
			}
		}
	
	
	if debris && !diddebris
	{
		repeat 4
		{
			with instance_create(x + sprite_width / 2, y + sprite_height / 2, obj_debris)
			{
				if blend != c_white
				{
					sprite_index = spr_secretdebris;
					image_blend = blend;
				}
				if sprite_exists(sprite)
					sprite_index = sprite;
				
				momentum = hspapply;
				image_xscale = abs(other.image_xscale);
				image_yscale = abs(other.image_yscale);
			}
		}
	}
}

function scr_secretbigdebris(debris = true, blend = c_white, sprite = -1, lay_ids = ["Tiles_1", "Tiles_2"])
{
	var diddebris = false;
	
	var hspapply = [0, 0];
	if variable_instance_exists(id, "momentum")
		hspapply = momentum;
	
	
		while array_length(lay_ids) > 0
		{
			var lay_id = get_layer(array_pop(lay_ids));
			if lay_id != -1
			{
				var map_id = layer_tilemap_get_id(lay_id);
				if map_id != -1
				{
					for(var xx = x; xx < x + sprite_width; xx += 32)
					{
						for(var yy = y; yy < y + sprite_height; yy += 32)
						{
							var data = tilemap_get_at_pixel(map_id, xx, yy);
							if data != -1 && data != 0
							{
								tilemap_set_at_pixel(map_id, tile_set_empty(data), xx, yy);
								if debris
								{
									if data != 0
									{
										with instance_create(xx + 16, yy + 16, obj_secretdebris)
										{
											tile_dataid = data
											tile_dataset = tilemap_get_tileset(map_id)
											momentum = hspapply
											if sprite_exists(sprite)
												sprite_index = sprite
										}
										diddebris = true;
									}
								}
							}
						}
					}
				}
			}
		}
	
	
	if !diddebris && debris
	{
		with instance_create(x + sprite_width / 2, y + sprite_height / 2, obj_debris)
		{
			if blend != c_white
			{
				sprite_index = spr_secretbigdebris;
				image_blend = blend;
			}
			else
				sprite_index = spr_bigdebris;
			
			if sprite_exists(sprite)
				sprite_index = sprite;
			momentum = hspapply
		}
	}
}