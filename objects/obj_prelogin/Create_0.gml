if room != characterselect
{
	scr_playerreset();
	room_goto(characterselect);
	exit;
}
global.firstjoin = false

ini_open("saved_login.ini")
autologin = ini_key_exists("Data", "user") && string_length(ini_read_string("Data", "user", "")) > 0 
&& ini_key_exists("Data", "token") && string_length(ini_read_string("Data", "token", "")) > 0
loggedinas = ini_read_string("Data", "user", "")
ini_close()

con = 0;
global.forcecorrectlogin = true
fmod_release_instance(global.music);
alarm[0] = 5;
with obj_player
{
	x = -500;
	y = -500;
	doorx = x;
	state = states.titlescreen;
}

playmusic = false;
with obj_shell
	WC_debug = false;

tryconnect = 0;
alpha = 0;

sel = 0;

