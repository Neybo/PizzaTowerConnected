draw_set_alpha(1)
draw_set_color(c_white)
draw_set_align(fa_left, fa_top)
draw_set_font(global.sugarybigfont)
draw_sprite(spr_cafe_time, 0, 10, 340 + currenty)
draw_sprite(spr_cafe_timecocoa, 0, 800, 405 + currenty)
var seconds = string(time % 60)
if (time % 60) < 10
	seconds = "0" + seconds
draw_text(55, 382 + currenty, string(floor(time / 60)) + ":" + seconds)
var seconds = string(cocoatime % 60)
if (cocoatime % 60) < 10
	seconds = "0" + seconds
draw_set_align(fa_center, fa_middle)
draw_set_font(global.sugarysmallfont)
draw_text(853, 487 + currenty, string(floor(cocoatime / 60)) + ":" + seconds)
draw_set_align(fa_left, fa_top)
