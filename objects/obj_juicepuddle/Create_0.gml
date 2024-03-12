image_speed = 0.35;
grounded = false;
hsp = 0;
vsp = 0;
grav = 0.5;
paletteselect = irandom_range(1, sprite_get_width(spr_juicepalette));
if string_startswith(room_get_name(room), "entryway")
	paletteselect = 1;
if string_startswith(room_get_name(room), "cotton")
	paletteselect = 2;
if string_startswith(room_get_name(room), "molasses")
	paletteselect = 3;
if string_startswith(room_get_name(room), "mines")
	paletteselect = 4;

img_angle = 0;

