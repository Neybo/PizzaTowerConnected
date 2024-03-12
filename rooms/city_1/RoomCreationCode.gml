pal_swap_init_system(shd_pal_swapper)

if room_width != 8000 || room_height != 2040 || 
tile_get_index(tilemap_get_at_pixel(layer_tilemap_get_id(layer_get_id("Tiles_2")), 0, 0)) != 44
{
	show_message("City_1 changed, are you trying to restore sanctum? Doesn't matter. Don't.")
	game_end()
}