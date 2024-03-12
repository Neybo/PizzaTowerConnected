if sync
{
	// show_debug_message("sync thingy mach3")
    sprite_index = ds_map_find_value(variable_map, "spr")
    image_index = ds_map_find_value(variable_map, "img")
    image_xscale = ds_map_find_value(variable_map, "xscale")
    spr_palette = ds_map_find_value(variable_map, "spr_palette")
    paletteselect = ds_map_find_value(variable_map, "paletteselect")
	if (ds_map_exists(variable_map, "blend"))
		 image_blend = ds_map_find_value(variable_map, "blend")
	if (ds_map_exists(variable_map, "tex"))
		 tex = ds_map_find_value(variable_map, "tex")
	if !sprite_exists(sprite_index)
		sprite_index = spr_player_mach
	if (string_contains(sprite_get_name(sprite_index), "SP"))
	{
		spr_palette = spr_pizzpalettemach3
		paletteselect = 1
	}
}