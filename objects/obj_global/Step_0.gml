// anti cheat
if global.saveslot == "" && !instance_exists(obj_gms) && room != characterselect
	global.saveslot = "1";

if onlinemode != global.onlinemode && !debug
{
	onlinemode = global.onlinemode;
	if room != Realtitlescreen && room != characterselect
		room_goto(room_of_dog);
}

// modifier shit
if global.modifier == mods.no_toppings
	global.failedmod = (global.toppings > 0);
else
	toppingsprite = -1;

if global.modifier == -1
	global.failedmod = false;

// switch fullscreen
if global.option_fullscreen && !window_get_fullscreen()
{
	switch global.option_resolution
	{
		case 0: window_set_size( 480, 270 ); break;
		case 1: window_set_size( 960, 540 ); break;
		case 2: window_set_size( 1920, 1080 ); break;
	}
}
global.option_fullscreen = window_get_fullscreen();

#region special functions
if keyboard_check_pressed(vk_f1)
{
	var file = file_text_open_write("Debuglogs\\" + text_time_file() + ".txt")
	file_text_write_string(file, scr_debug_text())
	file_text_close(file)
}
if keyboard_check_pressed(vk_f2)
{
	var place = "Screenshots\\" + text_time_file() + ".png"
	screen_save(place)
	show_debug_message(place)
}
if keyboard_check_pressed(vk_f3)
{
	gc_collect()
}
#endregion

if !global.muteuntabbed
	exit;
if mastervol != global.mastervolume || mastervol != 0
{
	if !window_has_focus() // lerp
		mastervol = lerp(mastervol, 0, 0.08)
	else
		mastervol = lerp(mastervol, global.mastervolume, 0.08)
	fmod_set_param_master("master_vol", mastervol * 0.75)
}
/*
if gifcount == 0
{
    gif_image = gif_open(960, 540);
	gifcount++;
}
else if gifcount < 60
{
    gif_add_surface(gif_image, application_surface, 1/60);
	gifcount++;
}
else if gifcount >= 60
{
    gif_save(gif_image, string(gifsmade) + ".gif");
    gifcount = 0;
	gifsmade++;
}
*/