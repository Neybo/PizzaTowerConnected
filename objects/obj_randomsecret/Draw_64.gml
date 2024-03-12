draw_set_align(fa_center, fa_middle)
draw_set_font(global.smallfont)
draw_set_color(c_white)

if seconds >= 0
	draw_text(480, 480,  "0:" + (seconds < 10 ? "0" : "") + string(seconds))
if secretsleft > -1
{
	draw_sprite(check_sugary() ? spr_secretsleft_ss : spr_secretsleft, 0, 64, 480)
	draw_text(64, 480, string(secretsleft))
}