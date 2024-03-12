function scr_gms_drawchat(_x, _y, username, userid, message, width, yscale, color, itsme = false)
{	
	// emoji
	var finalstr = message;
	
	if (itsme)
	{
		finalstr = string_replace_all(finalstr, ":fedora:", "\\e00");
		finalstr = string_replace_all(finalstr, ":awful:", "\\e01");
		finalstr = string_replace_all(finalstr, ":trolled:", "\\e02");
		finalstr = string_replace_all(finalstr, ":really:", "\\e03");
		finalstr = string_replace_all(finalstr, ":nice:", "\\e04");
		finalstr = string_replace_all(finalstr, ":fallback:", "\\e05");
		finalstr = string_replace_all(finalstr, ":eggplant:", "\\e06");
		finalstr = string_replace_all(finalstr, ":icepop:", "\\e07");
		finalstr = string_replace_all(finalstr, ":smile:", "\\e08");
		finalstr = string_replace_all(finalstr, ":sunglasses:", "\\e09");
		finalstr = string_replace_all(finalstr, ":shocked:", "\\e10");
	
		finalstr = string_replace_all(finalstr, "$r", "\\E00");
		finalstr = string_replace_all(finalstr, "$w", "\\E01");
		finalstr = string_replace_all(finalstr, "$s", "\\E02");
		finalstr = string_replace_all(finalstr, "$us", "\\E03");
	}
	
	// username - also prevents effects and shit in names
	if itsme
		name_gms_empty(username, global.storenickname);
	
	if username != ""
	{
		if global.streamer
			username = "Player" + string(userid);
		finalstr = username + ": " + finalstr;
	}
	
 
	// draw the text
	var xx = _x;
	var yy = _y;
	
	// get length until line break
	var w = width - 64;
	
	// other
	var fx = 0;
	var spacey = string_height("M");
	
	draw_set_colour(color);
	
	// letter per letter
	for(var i = 1; i <= string_length(finalstr); i++)
	{
		var letter = string_char_at(finalstr, i);
		
		if letter == "\\"
		{
			var getchar = string_char_at(finalstr, ++i);
			
			// emoji
			if getchar == "e"
			{
				draw_sprite(spr_emoji, string_char_at(finalstr, ++i) + string_char_at(finalstr, ++i), xx, yy - 8);
				xx += sprite_get_width(spr_emoji);
			}
			
			// effects
			if getchar == "E"
			{
				fx = real(string_char_at(finalstr, ++i) + string_char_at(finalstr, ++i));
			}
			continue;
		}
		
		if xx >= _x + w
		{
			xx = _x;
			yy += spacey
		}
		
		// effects
		switch fx
		{
			case 0: // reset
				draw_text_transformed(xx, yy, letter, 1, yscale, 0);
				break;
			case 1: // wavy
				draw_text_transformed(xx + cos(i + (get_timer() / 100000)), yy + sin(i + (get_timer() / 100000)), letter, 1, yscale, 0);
				break;
			case 2: // shaky
				draw_text_transformed(xx + random_range(-1, 1), yy + random_range(-1, 1), letter, 1, yscale, 0);
				break;
			case 3: // ultrashaky
				draw_text_transformed(xx + random_range(-3, 3), yy + random_range(-3, 3), letter, 1, yscale, random_range(-15, 15));
			break
		}
		xx += string_width(letter);
	}
}