function scr_hub_bg_init(parallaxmult = 1) //gml_Script_scr_hub_bg_init
{
   // bgsprite = spr_gate_entranceBG
    bgsprite_number = sprite_get_number(bgsprite)
    bgsprite_width = sprite_get_width(bgsprite)
    bgsprite_height = sprite_get_height(bgsprite)
    bgspritepos = 0
    bgspriteposstart = 0
    bgalpha = 1
    bg_useparallax = 0
    bgparallax = [(0.65 * parallaxmult), (0.75 * parallaxmult), (0.85 * parallaxmult)]
    bgparallax2 = [(0.1 * parallaxmult), (0.15 * parallaxmult), (0.2 * parallaxmult)]
    bgmask_surface = -4
    bgclip_surface = -4
}

function scr_hub_bg_reinit(argument0, argument1) //gml_Script_scr_hub_bg_reinit
{
    bgsprite_number = sprite_get_number(bgsprite) 
    bgsprite_width = sprite_get_width(bgsprite)
    bgsprite_height = sprite_get_height(bgsprite)
    for (var i = 0; i < bgsprite_number; i++)
    {
        bgspritepos[i] = 0
        if bg_useparallax
        {
            var p = bgparallax2[i]
            bgspriteposstart[i] = [((argument0 - (argument0 * p)) - ((960 / 4) * p)),
			((argument1 - (argument1 * p)) - ((540 / 4) * p))]
            bgspritepos[i] = [bgspriteposstart[i][0], bgspriteposstart[i][1]]
        }
    }
}

function scr_hub_bg_step() //gml_Script_scr_hub_bg_step
{
    for (i = 0; i < array_length(bgspritepos); i++)
    {
        if (!bg_useparallax)
        {
            bgspritepos[i] -= bgparallax[i]
            if (bgspritepos[i] <= (-((bgsprite_width + bgparallax[i]))))
                bgspritepos[i] = frac(bgspritepos[i])
        }
        else
        {
            p = bgparallax2[i]
            bgspritepos[i][0] = ((bgspriteposstart[i][0] + ((camera_get_view_x(view_camera[0]) 
			+ (960 / 2)) * p)) + ((960 / 5) * p))
            bgspritepos[i][1] = (bgspriteposstart[i][1] + ((camera_get_view_y(view_camera[0]) 
			+ (540 / 2)) * p))
        }
    }
}

function scr_hub_bg_draw(x_pos, y_pos, sprite, sprite_img, special_blend = false) //gml_Script_scr_hub_bg_draw
{
    if (bgalpha < 1)
    {
        var w = sprite_get_width(sprite)
        var h = sprite_get_height(sprite)
        var x1 = sprite_get_xoffset(sprite)
        var y1 = sprite_get_yoffset(sprite)
        if (!surface_exists(bgmask_surface))
        {
            bgmask_surface = surface_create(w, h)
            surface_set_target(bgmask_surface)
            draw_clear(c_black)
            gpu_set_blendmode(bm_subtract)
            draw_sprite(sprite, sprite_img, x1, y1) 
            if (!special_blend)
                gpu_set_blendmode(bm_normal)
            else
				gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha)
            surface_reset_target()
        }
        if (!surface_exists(bgclip_surface))
            bgclip_surface = surface_create(w, h)
        surface_set_target(bgclip_surface)
        draw_clear_alpha(c_black, 0)
        for (i = 0; i < array_length(bgspritepos); i++)
        {
            if (!bg_useparallax)
            {
                var b = bgspritepos[i]
                draw_sprite_tiled(bgsprite, i, b, h)
            }
            else
            {
                var bx = bgspritepos[i][0]
                var by = bgspritepos[i][1]
                draw_sprite_tiled(bgsprite, i, (bx - x_pos), ((by + h) - y_pos))
            }
        }
        gpu_set_blendmode(bm_subtract)
        draw_surface(bgmask_surface, 0, 0)
        if (!special_blend)
            gpu_set_blendmode(bm_normal)
        else
			gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha)
        surface_reset_target()
        draw_surface(bgclip_surface, (x_pos - x1), (y_pos - y1))
		gpu_set_blendmode(bm_normal)
    }
    if (bgalpha > 0)
        draw_sprite_ext(sprite, sprite_img, x_pos, y_pos, 
		image_xscale, image_yscale, image_angle, image_blend, bgalpha)
	
}

