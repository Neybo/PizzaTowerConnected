function scr_authtokensave(argument0){ // gms docs thanks
	if (!global.savethegmstoken)
		return;
	ini_open("saved_login.ini")
	ini_write_string("Data", "user", gms_self_name())
	ini_write_string("Data", "token", argument0)
	ini_close()
}