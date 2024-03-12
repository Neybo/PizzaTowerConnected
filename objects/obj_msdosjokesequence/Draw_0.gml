draw_set_colour(c_white);
draw_set_font(fnt_manual);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

for(var i = 0; i < ds_list_size(commandlines); i++)
	draw_text(4, 4 + i * 12, commandlines[|i]);

