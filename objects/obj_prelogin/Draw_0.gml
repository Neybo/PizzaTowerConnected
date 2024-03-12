scr_getinput();

if con == 0
{
	tryconnect = 0;
	
	var move = key_left2 + key_right2;
	if move != 0
	{
		sel += move;
		
		if sel < 0
			sel = 0;
		else if sel > 1
			sel = 1;
		else
			scr_soundeffect(sfx_step);
	}
	
	if draw_editorbutton((room_width / 2) - (192 / 2) - 120, (room_height / 2) - 48 / 2, lang_string("prelogin.offline"), sel == 0)
	or !global.onlinemode or (sel == 0 && key_jump)
	{
		if global.onlinemode
			scr_soundeffect(sfx_step);
		
		global.saveslot = "1";
		
		alpha = 0;
		event_user(0);
		con = 2;
		
		instance_destroy(obj_characterselect);
		instance_create(0, 0, obj_characterselect);
		instance_create(0, 71, obj_peppinoselect);
		instance_create(371, 170, obj_noiseselect);
	}
	else if (draw_editorbutton((room_width / 2) - (192 / 2) + 120, (room_height / 2) - 48 / 2, lang_string("prelogin.online"), sel == 1)
	or (sel == 1 && key_jump)) && global.onlinemode
	{
		scr_soundeffect(sfx_step);
		
		global.saveslot = "";
		if !os_is_network_connected()
		{
			scr_soundeffect(sfx_enemyprojectile)
			with obj_roomname
			{
				message = lang_string("prelogin.nonet");
				showtext = true;
				alarm[0] = 200;
			}
		}
		else
		{
			alarm[1] = 5;
			con = 1;
		}
	}
	else if (key_slap2)
	{
		if (instance_exists(obj_noiseselect))
		{
		scr_soundeffect(sfx_step);
			with obj_characterselect
				goback = true;
			instance_destroy(obj_peppinoselect);
			instance_destroy(obj_noiseselect);
			con = 0;
			
			if !playmusic
				alarm[0] = 1;
			with obj_roomname
				showtext = false
		}
		else
		room = Realtitlescreen;
	}
	if autologin
	{
		if (draw_editorbutton(720, 480, lang_str("prelogin.logout")))
		{
			scr_soundeffect(sfx_step);
			ini_open("saved_login.ini")
			ini_key_delete("Data", "user")
			ini_key_delete("Data", "token")
			ini_close()
			autologin = false
			with obj_roomname
			{
				message = lang_str("prelogin.loggedout");
				showtext = true;
				alarm[0] = 200;
			}
			global.forcecorrectlogin = false
		}
		
		draw_set_font(global.font_small);
		draw_set_colour(c_white);
	
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		
		draw_text(815, 440, lang_str("prelogin.curlogin") + "\n" + loggedinas)
	}
}
if con == 1
{
	draw_set_font(global.bigfont);
	draw_set_colour(c_white);
	
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text_auto(960 / 2 + random_range(-1, 1), 540 / 2, lang_string("prelogin.loading"));
	
	if tryconnect >= 300
	{
		if draw_editorbutton(64, 32, lang_string("prelogin.back")) or key_slap2
		{
			scr_soundeffect(sfx_step);
			instance_destroy(obj_gms);
			con = 0;
			
			alarm[0] = -1;
			alarm[1] = -1;
		}
	}
}
if con == 2
{
	if !(instance_exists(obj_characterselect) && obj_characterselect.ready) && global.onlinemode
	{
		if draw_editorbutton(64, 32, lang_string("prelogin.back")) or key_slap2
		{
			scr_soundeffect(sfx_step);
			with obj_characterselect
				goback = true;
			instance_destroy(obj_peppinoselect);
			instance_destroy(obj_noiseselect);
			con = 0;
			
			if !playmusic
				alarm[0] = 1;
			with obj_roomname
				showtext = false;
		}
	}
}
