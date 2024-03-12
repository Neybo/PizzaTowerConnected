if performance_destroy()
	exit;

surf = -4
if instance_exists(obj_racemenu) || obj_pause.pause
{
	instance_destroy();
	exit;
}

paletteselect = 0
spr_palette = spr_peppalette
tex = -4

sync = check_bysync();

depth = -4

alarm[0] = 15
alarm[1] = 3
if !sync && check_online()
	alarm[10] = 3;

playerid = obj_player
image_speed = 0
keep = false

visible = false

sugary = false;
color2 = c_black;

randomize()
if !sync && (playerid.character == "S" or playerid.character == "PP")
	image_blend = choose(make_color_rgb(255, 0, 0), make_color_rgb(0, 255, 0));
else if (playerid.character == "SP" || playerid.character == "SN") && FINAL_GAMEPLAY && !sync
{
	sugary = true;
	
	var chooser = choose(0, 1);
	if chooser == 0
	{
		image_blend = make_colour_rgb(232, 80, 152);
	//	color2 = make_colour_rgb(95, 9, 32);
	}
	else
	{
		image_blend = make_colour_rgb(48, 168, 248);
	//	color2 = make_colour_rgb(15, 57, 121);
	}
	
	// ??? who tf made this (patch for effect not del'ing after a bit on sp)
	//	alarm[0] = -1;
	//	alarm[1] = -1;
}
else
	image_blend = choose(make_colour_rgb(96, 208, 72), make_colour_rgb(248, 0, 0));

if instance_exists(playerid) && !sync
{
	sprite_index = playerid.sprite_index;
	if playerid.character == "SP"
	{
		spr_palette = spr_pizzpalettemach3;
		paletteselect = 1;
	}
	else
	{
		spr_palette = playerid.spr_palette;
		paletteselect = playerid.paletteselect;
	}
}

drawx = camera_get_view_x(view_camera[view_current]);
drawy = camera_get_view_y(view_camera[view_current]);

if !sync
	tex = global.texturelist[global.playertexture]

