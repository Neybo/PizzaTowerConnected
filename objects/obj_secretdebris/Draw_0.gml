if global.secretdebris && (tile_dataid != -1 or blendsprite != -1)
{
	if point_in_rectangle(x, y, camera_get_view_x(view_camera[0]) - 64, camera_get_view_y(view_camera[0]) - 64, (camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0])+64), (camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0]) + 64))
	{
		if !surface_exists(s)
		{
			// UNOWN > Only do these once
			s = surface_create(sprite_width, sprite_height);
			surface_set_target(s)
			draw_clear_alpha(c_white, 0)
			
			gpu_set_blendmode(bm_normal)
			draw_sprite_ext(sprite_index, image_index, sprite_xoffset, sprite_yoffset, image_xscale,
			image_yscale, 0, c_white, image_alpha)
			gpu_set_blendmode_ext(9, 6)
			
			draw_set_colour(c_white);
			if mode == 1
			{
				for (var i = -1; i < 2; i++) 
				{
					for (var z = -1; z < 2; z++) 
						draw_tile(tile_dataset, tile_dataid, 0, 32 * i, 32 * z);
				}
			}
			else
				draw_sprite_tiled(blendsprite, tile_dataid, 0, 0)
			
			gpu_set_blendmode(bm_normal)
			surface_reset_target()
			event_user(0);
		}
		else 
		{
			event_user(0);
		}
		
	}
}
else
{
	var spr = spr_debris;
	if sprite_index == spr_secretbigdebris
		spr = spr_bigdebris;
	if sprite_index == spr_secretmetaldebris
		spr = spr_metalblockdebris;
	
	draw_sprite_ext(spr, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
}
