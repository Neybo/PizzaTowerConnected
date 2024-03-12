/// @description global messages


// bind positions
gms_show_set_position(0,0,960,540)//_camx, _camy, _camx + _camw, _camy + _camh);

gms_chat_set_font(global.font_small);

draw_set_alpha(1);
gms_draw_gui();

if global.__chat
{
	minichatfade = 0;
	
	gms_chat_colors(c_white, c_black, 0.5);
	
	draw_set_alpha(0.75);
	draw_rectangle_color(0, 440, 960, 540, //_camx, _camy + _camh - 100, _camx + _camw, _camy + _camh, 
	c_black, c_black, c_black, c_black, false);
	draw_set_alpha(1);
	
	draw_set_font(global.font_small);
	draw_set_colour(c_white);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	
	draw_text(480, 490, //_camx + _camw / 2, _camy + _camh - 50, 
	lang_string("online.chat"));
	
	draw_set_halign(fa_left);
	draw_set_halign(fa_top);
}
else
{
	global.__chat_typing = false;
	global.__chat_openani = 0;
	
	if global.minichat && !instance_exists(obj_pausefadeout)
	{
		minichatfade--;
		with obj_player
		{
			if abs(hsp) > 1
				other.minichatfade = 120;
		}
		
		draw_set_alpha(0.5);
		if minichatfade <= 0
		{
			draw_rectangle_color(0, 340, 480, 540, //_camx, _camy + _camh - 180, _camx + _camw - (960 / 2), _camy + _camh,
			c_black, c_black, c_black, c_black, false);
			draw_set_alpha(1);
		}
		
		#region minichat
	
		var _y, _i, _t;
		_y = 540;
		
		draw_set_color(global.__chat_bgcol);
		draw_set_font(global.__chat_font);
		
		draw_set_color(global.__chat_textcol);
		draw_set_halign(fa_left)
		draw_set_valign(fa_top)
		
		var chatwidth = 555
		
		for(_i = gms_chat_num() - 1; _i >= 0 && _y > 340; _i -= 1)
		{
			if gms_chat_num() - _i > 10
				break;
			draw_set_color(gms_chat_get_color(_i))
			
			// figure out sender name
			var _snderid = gms_chat_get_sender(_i)
			
			
			var nick = gms_other_get_string(_snderid, "nickname")
			
			if gms_chat_get_sendername(_i) == gms_self_name()
			{
				nick = global.storenickname
			}
		
			var _snder = name_gms_empty(gms_chat_get_sendername(_i), nick);
			
			// positioning
			_t = string_replace_all(gms_chat_get_text(_i), "#", "\\#");
			_y -= string_height_ext(_snder + _t, -1, chatwidth - 80);
		
			scr_gms_drawchat(5, max(_y, 340), 
				_snder, gms_chat_get_sender(_i), _t, chatwidth, 1, gms_chat_get_color(_i))
		}
		
		#endregion
	}
	draw_set_alpha(1);
}

if showmessage
{
	// black overlay
	draw_set_colour(c_black);
	draw_set_alpha(0.25);
	draw_rectangle(0, 0, 960, 540, false);
	
	// prepare text
	draw_set_alpha(1);
	draw_set_colour(c_white);
	draw_set_font(global.font_small);
	
	// person says...
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	if is_string(__author) && __author != ""
		draw_text(960 / 2, (540 / 2) - 20, __author + " " + lang_string("online.global.says") + "\n");
	else
		draw_text(960 / 2, (540 / 2) - 20, lang_string("online.global") + "\n");
	
	// message
	var msgstr = global.__gotmessage[1];
	if !is_string(msgstr)
		msgstr = lang_string("online.global.error");
	draw_text_ext_transformed((960 / 2) + random_range(-1, 1), 540 / 2, "\n" + msgstr, 16, 960 / 2, 2, 2, 0);
	
	// reset align
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
}

if disconnected
{
	draw_set_font(global.bigfont);
	draw_set_colour(c_white);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	
	draw_text_auto((960 / 2) + random_range(-1, 1), 540 / 2, lang_string("online.reconnecting"));
	
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
}

