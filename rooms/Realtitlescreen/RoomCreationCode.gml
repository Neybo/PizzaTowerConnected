// logged out message
if instance_exists(obj_gms)
{
	instance_destroy(obj_gms);
	with obj_roomname
	{
		message = lang_string("online.loggedout");
		global.roommessage = message;
		showtext = true;
		alarm[0] = 200;
	}
}
if variable_global_exists("logged")
	global.logged = false;

// sertif being a dumbass
global.jukebox = FMOD_EMPTY;

if os_is_network_connected()
while variable_global_exists("__loggedin") && gms_info_isloggedin()
		gms_logout();

// reset player properly
with obj_player
{
	global.modifier = -1;
	global.hatunlock = [true];
	
	scr_playerreset();
	state = states.titlescreen;

	targetDoor = "A";
	character = "P";
	
	// paletteselect = check_shaders();
	
	petfollow = -1;
	hatsprite = -1;
	//	noisetype = (OLD_GAMEPLAY ? 0 : 1);
	x = 480;
	y = 402;
	scr_characterspr();
	scr_peploadpal(id, global.palsel)
}

with obj_shell
	WC_debug = false;
global.panic = false;
global.snickchallenge = false;
global.snickrematch = false;

room_speed = 60;
if !instance_exists(obj_fadein)
	instance_create(0, 0, obj_fadein);
video_close()
if global.lsdtrip
	scr_soundeffect(sfx_collectgiantpizza_PP)
