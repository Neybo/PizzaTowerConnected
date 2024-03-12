if state == 1
{
	draw_set_font(global.bigfont);
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);
	
	var middlex = 960 / 2;
	var middley = 540 / 2;
	
	var sepy = 32;
	var yy = middley - ((array_length(hub_array) * sepy) / 2);
	
	// border vars
	var rborder = 16;
	var rx = middlex;
	var ry = yy;
	var rw = middlex;
	var rh = yy + (array_length(hub_array) * sepy);
	
	// calculate preffered border size
	for(var i = 0; i < array_length(hub_array); i++)
	{
		var txt = hub_array[i][0];
		
		var rx_target = (middlex - string_width(txt) / 2);
		if rx > rx_target
			rx = rx_target;
		var rw_target = (middlex + string_width(txt) / 2);
		if rw < rw_target
			rw = rw_target;
	}
	
	// thicken border
	rx -= rborder;
	rw += rborder;
	ry -= rborder;
	rh += rborder;
	
	// draw the border
	draw_set_colour(c_black);
	draw_set_alpha(0.5);
	draw_roundrect(rx - 32, ry, rw + 33, rh + 32, false);
	draw_set_alpha(1);
	draw_set_colour(c_white);
	
	// draw the actual text
	for(var i = 0; i < array_length(hub_array); i++)
	{
		var c = sel == i ? c_white : c_gray;
		var txt = hub_array[i][0];
		
		draw_set_colour(c);
		draw_text_auto(480, yy + (sepy * i), txt);
	}
	
	//drawing arrows + categories
	draw_sprite_ext(spr_inputdisplay_arrow, 0, rx, rh + 10, 0.75, 0.75, 90, c_white, 1)
	draw_set_font(global.font_small);
	draw_set_color(c_yellow);
	draw_text_auto(480, rh, categories[categoryindex]);
	draw_sprite_ext(spr_inputdisplay_arrow, 0, rw, rh + 10, 0.75, 0.75, 270, c_white, 1)
}