working = false;
if room != characterselect
{
	room_goto(room_of_dog);
	exit;
}
working = true;

with obj_shell
	WC_debug = false;

// init
gms_init(obj_gms);
depth = -9999;
// syncable objects
if global.synceffect
{
	gms_settings_declare_syncable_object(obj_taunteffect);
	gms_settings_declare_syncable_object(obj_cloudeffect);
	gms_settings_declare_syncable_object(obj_keyeffect);
	gms_settings_declare_syncable_object(obj_mach3effect);
	gms_settings_declare_syncable_object(obj_slapstar);
}

// settings
gms_settings(game_version, , obj_otherplayer);

// settings
global.__chat_bubbles = global.chatbubbles;
global.showcollision = false;
global.minichat = false;
chatopen = false;
disconnected = false;

//chat_lastmessage = ""; // up arrow key in chat
global.raceid = 0;

// gots
global.gottp = [false, x, y, room];
global.__gotmessage = [false, "message", "author"];
showmessage = false;
__author = "author";

minichatfade = 0;
loadsave = false;

req = -1