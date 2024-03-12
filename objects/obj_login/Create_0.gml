if room != characterselect
{
	room_goto(room_of_dog);
	exit;
}
global.savethegmstoken = true
tokenlogin = false
showtoken = true

yOffsetREMEMBER = 500

ini_open("saved_login.ini")
if ini_key_exists("Data", "user") && string_length(ini_read_string("Data", "user", "")) > 0 
&& ini_key_exists("Data", "token") && string_length(ini_read_string("Data", "token", "")) > 0
&& global.forcecorrectlogin
{
    gms_login_set_username(ini_read_string("Data", "user", ""))
    gms_login_set_token(ini_read_string("Data", "token", ""))
	gms_script_set_authentication_token_received(scr_authtokensave)
    gms_login_execute(scr_trylogintoken)
	gms_show_set_fonts(global.bigfont, global.font_small, global.font_small);
	
	gms_show_set_constant("c_text", c_white)
	gms_show_set_constant("c_grey_text", c_ltgray)
	gms_show_set_constant("c_fault_color", merge_colour(c_red, c_white, 0.25))
	gms_show_set_constant("c_button1", make_colour_rgb(176, 120, 152))
	gms_show_set_constant("c_button2", make_colour_rgb(120, 104, 152))
	gms_show_set_constant("c_background1", make_colour_rgb(round(161 / 2), round(122 / 2), round(144 / 2)))
	gms_show_set_constant("c_background2", make_colour_rgb(round(122 / 2), round(111 / 2), round(144 / 2)))
	gms_show_set_constant("c_border", c_black)
	
	gms_show_set_constant("txt_loginheader", lang_string("login.headlogin"))
	gms_show_set_constant("txt_registerheader", lang_string("login.headreg"))
	gms_show_set_constant("txt_login", lang_string("login.login"))
	gms_show_set_constant("txt_username", lang_string("login.username"))
	gms_show_set_constant("txt_password", lang_string("login.password"))
	gms_show_set_constant("txt_cancel", lang_string("login.cancel"))
	gms_show_set_constant("txt_email", lang_string("login.email"))
	gms_show_set_constant("txt_register", lang_string("login.register"))
	gms_show_set_constant("txt_repeat_password", lang_string("login.passrepeat"))
	gms_show_set_constant("txt_guest", "")
	
	scr_loginwindowcss();
	
	wle_perform(global.__xls_window, 48, true);
	
	loading = false
	tokenlogin = true
	showtoken = false
	global.forcecorrectlogin = true
} else {
	event_user(0)
	showtoken = true
	global.forcecorrectlogin = true

}
ini_close()
