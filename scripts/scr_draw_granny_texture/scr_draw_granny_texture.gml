function scr_draw_granny_texture(x, y, xscale, yscale, tex_x, tex_y, 
sprite = spr_diatexture_placeholder, bubble_sprite = spr_tutorialbubble)
{
	var w = sprite_get_width(bubble_sprite) * xscale;
	var h = sprite_get_height(bubble_sprite) * yscale;
	
	if (!surface_exists(surfclip))
		surfclip = surface_create(w, h);
	if (!surface_exists(surffinal))
		surffinal = surface_create(w, h);
	
	// draw dialog box
	surface_set_target(surfclip);
	draw_clear_alpha(0, 0);
	draw_rectangle_color(0, 0, w, h, c_white, c_white, c_white, c_white, false);
	gpu_set_blendmode(bm_subtract);
	draw_sprite_ext(bubble_sprite, 0, 0, 0, xscale, yscale, 0, c_white, 1);
	reset_blendmode();
	surface_reset_target();
	
	// draw the looping texture
	surface_set_target(surffinal);
	draw_sprite_tiled(sprite, 0, tex_x, tex_y);
	gpu_set_blendmode(bm_subtract);
	draw_surface(surfclip, 0, 0);
	reset_blendmode();
	surface_reset_target();
	
	// draw everything
	draw_surface(surffinal, x, y);
	gpu_set_blendmode(bm_normal);
}

function reset_blendmode()
{
	gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);
}