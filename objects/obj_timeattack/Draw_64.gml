if global.timeattack && !(instance_exists(obj_gms) && global.__chat)
{
	var middletext = ":";
	if global.taseconds < 10
		middletext = ":0";
	
	// i don't know how speedrun timers work but i hope this is close enough
	if newalarm > -1 && !stop && !(instance_exists(obj_pause) && obj_pause.pause)
		global.tadecimal = floor(100 - ((newalarm / 60) * 100));
	
	var precise = clamp(global.tadecimal, 0, 99);
	var precisertext = ".";
	if precise < 10
		precisertext = ".0";
	
	draw_set_font(global.bigfont)
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);
	draw_set_color(c_yellow)
	
	var yy = min(obj_tv.yi - 70 - (check_sugary() * 10), 540 - 60);
	if global.panic or global.snickchallenge or global.modifier == mods.no_toppings
		yy -= 40;
	var xx = 960 / 2;
	
	if !stop && newalarm > -1
	{
		xx += random_range(1, -1);
		yy += random_range(1, -1);
	}
	
	var finalstr = string(global.taminutes) + middletext + string(global.taseconds);
	draw_text(xx, yy, finalstr);
	
	var strw = string_width(finalstr) / 2;
	draw_set_font(global.font_small);
	draw_set_halign(fa_left);
	draw_text(xx + strw, yy + 16, precisertext + string(precise));
}

