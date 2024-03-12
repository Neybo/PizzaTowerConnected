// roundrect
//draw_set_colour($222222);

var xx = 50;
var yy = (190 * size) + 180;
//var xsiz = (960 / 2);
//var ysiz = (540 / 2) * (1 - size);
//var rectsize = 5;

draw_set_alpha(1);
draw_set_colour(c_black);
//ah shit here comes pizzagranny
//draw_roundrect_ext(xx + xsiz, yy + ysiz + yplus, 960 - xx - xsiz, 540 - yy - ysiz + yplus, 16, 16, false);
//draw_roundrect_ext(xx + xsiz + rectsize, yy + ysiz + rectsize + yplus, 960 - xx - xsiz - rectsize, 540 - yy - ysiz - rectsize + yplus, 16, 16, false);
//draw_set_alpha(1);
tex_x -= 0.5
scr_draw_granny_texture(xx + xplus,yy + yplus, text_xscale, text_yscale, tex_x, tex_x, texture)

if con == 1
{
	draw_set_colour(c_black);
	draw_set_halign(fa_left);
	draw_set_halign(fa_top);
	draw_set_font(global.diafont);
	
	var xst = 90;
	var yst = 390;
	
	if face != -1
	{
		xst = 220;
		if sprite_exists(face)
			draw_sprite_ext(face, 0, 140, 440, 1, 1, 0, c_white, 1);
	}
	
	var xx = xst;
	var yy = yst;
	var curstring = ""
	
	var effect = -1;
		for(var i = 1; i <= writer; i++)
	{
	var cur_l = string_char_at(dialogue[curdiag], i);
	if string_width(curstring + cur_l) > 770
	curstring += "\n"
	curstring += cur_l
	}
	draw_text(xx, yy, curstring);
	// draw the text
	/*for(var i = 1; i <= writer; i++)
	{
		var cur_l = string_char_at(dialogue[curdiag], i);
		
		// line breaks
		if cur_l == "\n" // chr(10)
		or (cur_l == " " && xx >= xst + 790) // auto newliner
		{
			yy += 20;
			xx = xst;
			continue;
		}
		
		// dont draw the stops dumbass
		if cur_l == "^"
		{
			i++;
			continue;
		}
		
		// modifiers idk
		if cur_l == "\\"
		{
			i++;
			if string_char_at(dialogue[curdiag], i) == "c" // choice
			{
				++i;
				// placeholder, didn't add choices yet...
			}
			if string_char_at(dialogue[curdiag], i) == "%" // skip
			{
				var e = string_char_at(dialogue[curdiag], ++i);
				if e == "%"
				{
					if playsound
						scr_soundeffect(sfx_diagcancel);
					con = 2;
				}
				else
				{
					writer = 0;
					curdiag++;
				}
			}
			if string_char_at(dialogue[curdiag], i) == "e" // effect
			{
				var e = string_char_at(dialogue[curdiag], ++i);
				if e == "0" // reset
					effect = -1;
				if e == "S" // SHAKE
					effect = 0;
			}
			continue;
		}
		
		// draw the text, depending on the effect!
		switch effect
		{
			default:
				draw_text(xx + random_range(-1, 1), yy + random_range(-1, 1), cur_l);
				break;
			case 0: // shaking
				draw_text(xx + random_range(-3, 3), yy + random_range(-3, 3), cur_l);
				break;
		}
		
		// shift next letter
		xx += 12;
		
		// some letters are bigger or smaller than others
		if cur_l == "l" or cur_l == "i" or cur_l == "!" or cur_l == "j" or cur_l == "I" or cur_l = "'"
			xx -= 4;
		if cur_l == "w" or cur_l == "m" or cur_l == "M" or cur_l == "W"
			xx += 3;
	}*/
	
	if writer >= string_length(dialogue[curdiag])
	{
		concon = (concon + 0.35) % 2;
		draw_sprite(spr_diagcontinue, concon, 890, 500);
	}
}
