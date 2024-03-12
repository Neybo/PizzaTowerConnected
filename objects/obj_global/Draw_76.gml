/// @description border
// level background
	
var display = display_values();
var winw = display.winw, winh = display.winh;
if frac(winw / 960) == frac(winh / 540)
	exit;

var appx = floor(display.appx), appw = floor(display.appw), 
apph = floor(display.apph), appy = floor(display.appy);

if !surface_exists(surf)
	surf = surface_create(winw, winh);
else
{
	surface_set_target(surf);
	
	draw_clear_alpha(c_black, 0);
	draw_set_colour(c_black);
	if !global.drawborder
		draw_sprite_tiled(spr_hubtv_base, 0, 0, 0);
	else
		draw_sprite_tiled(borderspr, 0, 0, 0);

	gpu_set_blendmode(bm_subtract);
	draw_rectangle(appx, appy, appx + appw - 1, appy + apph - 1, false);
	gpu_set_blendmode(bm_normal);
	
	surface_reset_target();
	draw_surface(surf, 0, 0);
}

draw_set_colour(c_black);
draw_rectangle(appx - 2, 0, appx, winh, false);
draw_rectangle(appx + appw, 0, appx + appw + 1, winh, false);

