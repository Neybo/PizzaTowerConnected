if !active
	exit; // make sure nothing is drawn before performance mode is checked
	
if !surface_exists(lapsurf)
	lapsurf = surface_create(960, 540)

surface_set_target(lapsurf)
draw_clear_alpha(c_white, 0)
var xshake = irandom_range(-1, 1)
var yshake = irandom_range(-1, 1)
draw_sprite(sprite_index, 0, x + xshake, y + 100 + yshake);
var _cx = x + 60 + xshake
var _cy = y + 40 + yshake
var _str = string(global.lap + 1)
draw_set_color(c_white)
if _str == "4"
{
	gpu_set_alphatestenable(true);
	draw_set_font(global.lapshadow)
	gpu_set_blendmode_ext(bm_dest_color, bm_zero);
	draw_text(_cx - 10, _cy + 40, "4")
	gpu_set_blendmode(bm_normal)
	draw_set_font(global.lapfont)
	draw_text(_cx - 10, _cy + 40, "4")
}
else
{
	var num = string_length(_str)
	for (var i = 1; i <= num; i++)
	{
		gpu_set_alphatestenable(true);
	    var char = string_char_at(string(global.lap + 1), i)
		draw_set_font(global.lapshadow)
		gpu_set_blendmode_ext(bm_dest_color, bm_zero);
	    draw_text(_cx, _cy, char)
		gpu_set_blendmode(bm_normal)
		draw_set_font(global.lapfont)
		draw_text(_cx, _cy, char)
	    _cx += 53
	}
}
gpu_set_alphatestenable(false);
surface_reset_target()
pal_swap_set(spr_lappal, paletteselect, false)
draw_surface(lapsurf, 0, 0)
pal_swap_reset()