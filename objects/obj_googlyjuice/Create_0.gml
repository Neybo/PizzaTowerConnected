event_inherited();

idlespr = spr_juicewalk
stunfallspr = spr_juicestun
walkspr = spr_juicewalk
grabbedspr = spr_juicestun
scaredspr = spr_juicescared
spr_dead = -1 // dont use death sprite.
hp = 1

paletteselect = irandom_range(1, sprite_get_width(spr_juicepalette));
if string_startswith(room_get_name(room), "entryway")
	paletteselect = 1;
if string_startswith(room_get_name(room), "cotton")
	paletteselect = 2;
if string_startswith(room_get_name(room), "molasses")
	paletteselect = 3;
if string_startswith(room_get_name(room), "mines")
	paletteselect = 4;
spr_palette = spr_juicepalette;

sugaryenemy = true;

