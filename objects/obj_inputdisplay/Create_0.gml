function defaultkeys()
{
	event_user(0)
	
	keysep = 4;
	keysize = 48;
	
	pos[0] = keysep;
	pos[1] = (520 - keysize * 3) - keysep * 3;
	
	pressedcol = merge_colour(c_blue, c_aqua, 0.75);
}
pressedcol = merge_colour(c_blue, c_aqua, 0.75);
function draw_inputdisplay_key(xx, yy, keycode, width, height = width)
{
	var drawer = keycode;
	var pressed = false;
	if instance_exists(obj_player)
	{
		switch keycode
		{
			default: pressed = keyboard_check(scr_keyfromname(keycode)); break;
			case "SHIFT": pressed = obj_player.key_attack; break;
			case "Z": pressed = obj_player.key_jump2; break;
			case "X": pressed = obj_player.key_slap; break;
			case "C": pressed = obj_player.key_taunt; break;
			case "A": pressed = obj_player.key_shoot; break;
			case "S": pressed = obj_player.key_chainsaw; break;
			case "V": pressed = obj_player.key_extra; break;
			case "UP": drawer = 0; pressed = obj_player.key_up; break;
			case "DOWN": drawer = 180; pressed = obj_player.key_down; break;
			case "LEFT": drawer = 90; pressed = -obj_player.key_left; break;
			case "RIGHT": drawer = 270; pressed = obj_player.key_right; break;
		}
	}
	else
	{
		scr_getinput(,1)
		switch keycode
		{
			default: pressed = keyboard_check(scr_keyfromname(keycode)); break;
			case "SHIFT": pressed = key_attack; break;
			case "Z": pressed = key_jump2; break;
			case "X": pressed = key_slap; break;
			case "C": pressed = key_taunt; break;
			case "A": pressed = key_shoot; break;
			case "S": pressed = key_chainsaw; break;
			case "V": pressed = key_extra; break;
			case "UP": drawer = 0; pressed = key_up; break;
			case "DOWN": drawer = 180; pressed = key_down; break;
			case "LEFT": drawer = 90; pressed = -key_left; break;
			case "RIGHT": drawer = 270; pressed = key_right; break;
		}
	}
	
	// square
	draw_set_alpha(image_alpha);
	draw_set_colour(pressed ? pressedcol : c_ltgray);
	draw_roundrect(xx, yy, xx + width - 1, yy + height - 1, false);
	
	draw_set_colour(c_black);
	draw_roundrect(xx, yy, xx + width - 1, yy + height - 1, true);
	
	// text
	if is_string(drawer)
	{
		draw_set_colour(c_white);
		draw_set_font(global.bigfont);
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
	
		var siz = 1;
		var _stringwidth = string_width(drawer);
		
		siz = (width - 16) / _stringwidth;
		if siz > 1
			siz = max(floor(siz / 2), 1);
	
		if siz != 1
			draw_text_transformed(floor(xx + width / 2), floor(yy + height / 2), drawer, siz, siz, 0);
		else
			draw_text(floor(xx + width / 2), floor(yy + height / 2), drawer);
	
		draw_set_valign(fa_top);
	}
	else
	{
		siz = (width - 16) / 28;
		if siz > 1
			siz = max(floor(siz / 2), 1);
		draw_sprite_ext(spr_inputdisplay_arrow, 0, floor(xx + width / 2), floor(yy + height / 2), siz, siz, drawer, c_white, image_alpha);
	}
	
	draw_set_alpha(1);
}
function savekeys()
{
	file = file_text_open_write("inputdisplayNEWNEW");
	
	file_text_write_real(file, x);
	file_text_writeln(file);
	file_text_write_real(file, y);
	file_text_writeln(file);
	file_text_write_real(file, keysep);
	file_text_writeln(file);
	file_text_write_real(file, keysize);
	file_text_writeln(file);
	file_text_write_real(file, pos[1] - y);
	
	file_text_close(file);
}
function loadkeys()
{
	file = file_text_open_read("inputdisplayNEWNEW");
	
	x = file_text_read_real(file);
	file_text_readln(file);
	y = file_text_read_real(file);
	file_text_readln(file);
	keysep = file_text_read_real(file);
	file_text_readln(file);
	keysize = file_text_read_real(file);
	file_text_readln(file);
	pos[0] = keysep;
	pos[1] = (520 - keysize * 3) - keysep * 3;
	
	file_text_close(file);
}

extrakeys = false
clicktimer = 0;
drag = false;
dragoffset = [0, 0];

depth = -10000;
lengtharray = 10
inputkeys = [];
pos = [0, 0];

if !file_exists("inputdisplayNEWNEW")
{
	defaultkeys();
	savekeys();
}
else
{
	loadkeys();
	event_user(0)
	if pos[0] < 0 or pos[1] < 0
	{
		defaultkeys();
		savekeys();
	}
}

