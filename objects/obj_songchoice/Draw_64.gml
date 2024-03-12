event_inherited();

if (!searching)
{
	// disc
	draw_sprite_ext(bg_jukeboxdisc, sel[0], 640, 280, 2, 2, discrot, c_white, 0.6 * talpha);

	// song names
	var _palname = selarray[sel[1]][1];
	var _paldesc = selarray[sel[1]][2];

	draw_set_alpha(talpha);

	draw_set_halign(fa_center);
	draw_set_valign(fa_bottom);
	draw_set_font(titlefont);
	draw_text_auto((960 / 1.5) + random_range(-1, 1), 540 - 250 + yoffset, _palname,,,talpha);

	draw_set_valign(fa_top);
	draw_set_font(descfont);
	draw_text_auto(960 / 1.5, 540 - 234 + yoffset, _paldesc, 16, 960 - 32, talpha);

	// game names
	for(var i = 0; i < array_length(gamearray); i++)
	{
		draw_set_colour(sel[0] == i ? c_white : c_gray);
		draw_text(lerp(150, 960 - 150, i / (array_length(gamearray) - 1)), 32, gamearray[i]);
	}

	// song list
	draw_set_halign(fa_left);

	var scroller = max((sel[1] - 8) * 16, 0);
	for(var i = 0; i < array_length(selarray); i++)
	{
		var yy = 128 + i * 16;
		yy -= scroller;
	
		if yy < 0
			continue;
		if yy > 540
			break;
	
		if yy <= 128
			draw_set_alpha((yy / 128) * talpha);
		if yy > 540 - 128
			draw_set_alpha(((540 - yy) / 128) * talpha);
	
		draw_set_colour(sel[1] == i ? c_white : c_ltgray);
		draw_text(64, yy, string_replace_all(selarray[i][1], "\n", " "));
	}

	img += 0.35;
	draw_set_alpha(talpha);
	draw_sprite(spr_cursor, img, 64 - 36, 128 + 10 - scroller + sel[1] * 16);

	// song position
	var pos = 0;
	if playing
	{
		if global.jukebox != FMOD_EMPTY && fmod_get_instance_name(global.jukebox) == selarray[sel[1]][0]
		{
			pos = (fmod_get_instance_timeline_pos(global.jukebox) / 
			fmod_get_event_length(fmod_get_instance_name(global.jukebox))) * 460;
			if array_length(selarray[sel[1]]) > 3
				discrot -= selarray[sel[1]][3];
			else
				discrot -= 1;
		}
	}
	
	draw_set_colour(c_gray);
	draw_rectangle(400, 350 + yoffset, 400 + 480, 350 + 15 + yoffset, false);
	draw_set_colour(c_white);

	draw_rectangle(400, 350 + yoffset, 400 + pos, 350 + 15 + yoffset, false);
	draw_circle(400 + pos, 350 + 15 / 2 + yoffset, 15, false);

	draw_set_halign(fa_center);
	draw_text(640, 500, lang_str("msg.songchoice.adsrch.tip"))

	draw_set_colour(c_black);
	draw_circle(400 + pos, 350 + 15 / 2 + yoffset, 15, true);
}
else
{
	draw_set_halign(fa_center);
	draw_set_colour(c_white);

	draw_set_font(titlefont);

	draw_text(256, 260, lang_str_upper("msg.songchoice.adsrch.title"))
	
	draw_set_font(descfont);
	
	
	draw_text(256, 130, lang_str("msg.songchoice.adsrch.desc1"))

	draw_text(256, 350, lang_str("msg.songchoice.adsrch.desc2"))

	draw_sprite_ext(bg_jukeboxdisc, 0, 725, 280, 2, 2, discrot, c_white, 0.6 * talpha);

	// song position
	var pos = 0;
	if global.jukebox != FMOD_EMPTY && fmod_is_instance_playing(global.jukebox)
	{
		pos = (fmod_get_instance_timeline_pos(global.jukebox) / 
		fmod_get_event_length(fmod_get_instance_name(global.jukebox))) 
		* 460;
		discrot -= 1;
	}

	draw_set_colour(c_gray);
	draw_rectangle(495, 350 + yoffset, 495 + 460, 350 + 15 + yoffset, false);
	draw_set_colour(c_white);
	draw_rectangle(495, 350 + yoffset, 495 + pos, 350 + 15 + yoffset, false);
	draw_circle(495 + pos, 350 + 15 / 2 + yoffset, 15, false);
	draw_set_colour(c_black);
	draw_circle(495 + pos, 350 + 15 / 2 + yoffset, 15, true);

	draw_set_colour(c_ltgray);
	draw_text(256, 310, keyboard_string + (((get_timer() / 1000000 % 1) > 0.5 && keyboard_string == "") ? ".." : "" ))
}

draw_set_alpha(1);

