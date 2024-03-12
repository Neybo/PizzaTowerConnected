draw_set_colour(c_white);
draw_set_align(fa_center, fa_middle);
draw_set_font(loadfont);
var spr_w = sprite_get_width(spr_loadingscreen)
var spr_h = sprite_get_height(spr_loadingscreen)
var xx = floor(480 - spr_w / 2)
var yy = floor(270 - spr_h / 2)
switch loadwhat
{
	default:
		draw_sprite(spr_loadingscreen, 0, xx, yy)
		draw_text(960 / 2, 500, lang_string("load.loading"));
		break;
	
	case 0:
		if !ds_exists(tex_list, ds_type_list)
		{
			alarm[1] = 0
		    break;
		}
		var p = tex_max - ds_list_size(tex_list);
		var t = (p / tex_max);
		draw_sprite(spr_loadingscreen, 0, xx, yy)
		draw_sprite_part(spr_loadingscreen, 1, 0, 0, spr_w * t, spr_h, xx, yy)
		draw_text(960 / 2, 500, lang_string("load.txgrp"));
		
		break;
	
	case -5:
		draw_text(960 / 2, 500, lang_string("load.loading"));
		draw_sprite(spr_loadingscreen, 1, xx, yy)
		break;
	
	/*case 1:
		// load audio groups
		for (var i = 1; audio_group_name(i) != undefined; i++)
		{
			if !audio_group_is_loaded(i)
			{
				if !audio_group_load(i)
					show_error("Audio group " + audio_group_name(i) + " is missing!", true);
			}
		}
		loadwhat = 2;
		break;*/
}
draw_set_align();
