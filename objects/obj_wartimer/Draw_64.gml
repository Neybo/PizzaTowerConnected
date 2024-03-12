
var xx = 320
var yy = timer_y

if (obj_player.y > room_height - 139)
    draw_set_alpha(0.3)
else
    draw_set_alpha(1)
	
draw_sprite(spr_wartimer, addseconds > 0, xx, yy)
	
if (addseconds <= 0)
    draw_set_font(wartimerfont1)
else
    draw_set_font(wartimerfont2)
	
draw_set_halign(fa_left)
draw_set_valign(fa_middle)
draw_set_color(c_white)

var t = string(minutes)
if (minutes < 10)
    t = "0" + t
var q = string(seconds)
if (seconds < 10)
    q = "0" + q
	
var x2 = (xx - 65)
var y2 = (yy + 70)

draw_text(x2 + 165, y2, string_char_at(t, 1))
draw_text(x2 + 208, y2, string_char_at(t, 2))

x2 = (xx + 51)

draw_text(x2 + 165, y2, string_char_at(q, 1))
draw_text(x2 + 208, y2, string_char_at(q, 2))

draw_set_alpha(1)
