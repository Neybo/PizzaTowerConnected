var xx = obj_player.x
var yy = obj_player.y - 100

var title = floor(combo / 5)
if sugary && title >= 6
	draw_sprite(spr_wtfcombo_boil, -1, xx, yy + 30)
else
{
	draw_sprite(spr_comboend, 0, xx, yy)
	
	title = clamp(title, 0, floor(sprite_get_number(spr_comboend_title1) / 5))
	draw_sprite(sugary ? spr_comboend_titleSP : spr_comboend_title1, (title * 2) + title_index, xx, yy + 30)
}

draw_set_font(global.smallfont)
draw_set_halign(fa_center)
draw_set_valign(fa_top)
draw_set_colour(c_white)
draw_text(xx, yy + 60, comboscore)
