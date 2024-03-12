//Draw Text
draw_set_font(global.smallnumber)
draw_set_halign(fa_center);
draw_set_color(c_white);

draw_set_alpha(image_alpha);

x = obj_player.x + random_range(-shake, shake);
y = obj_player.y - 60 + random_range(-shake, shake);

var str = string(scr_getcoin());
draw_sprite(spr_pizzacoin, -1, x - floor(string_width(str) / 2) - 16, y - 60)
draw_text(x + 15, y - 60, str)

draw_set_alpha(1);

