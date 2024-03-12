function scr_drawtexture(sprite, subimg, x2, y2, xscale2, yscale2, rot, col, 
alpha, tex = global.texturelist[global.playertexture], sizex = 224, sizey = 200, scale = 1, texpal = spr_peptexture)
{
	if tex == noone
		exit;

	if !surface_exists(surf)
	{
		surf = surface_create(sizex, sizey);
	}
	
	surface_set_target(surf);
	gpu_set_blendenable(false)
	gpu_set_colorwriteenable(false,false,false,true);
	draw_set_alpha(0);
	draw_clear_alpha(c_white, 0);
	draw_set_alpha(1);
	pal_swap_set(texpal, 1, false, 0, true);
	
	draw_sprite_ext(sprite, subimg, sizex / 2, sizey / 2, xscale2, yscale2, rot, col, 1);
	pal_swap_reset()
	gpu_set_blendenable(true);
	gpu_set_colorwriteenable(true,true,true,true);
	gpu_set_blendmode_ext(bm_dest_alpha,bm_inv_dest_alpha);
	gpu_set_alphatestenable(true);
	draw_sprite_tiled_ext(tex, 0, 0, 0, scale, scale, c_white, 1)
	gpu_set_alphatestenable(false);
	gpu_set_blendmode(bm_normal);
	surface_reset_target();
	draw_surface_ext(surf, x2 - sizex / 2, y2 - sizey / 2, 1, 1, 0, col, alpha);
}

function surf_free(surface = surf)
{
	if surface_exists(surface)
	{ 
		surface_free(surface)
		return true;
	}
	return false;
}