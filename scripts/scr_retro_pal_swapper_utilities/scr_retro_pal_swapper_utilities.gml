/// @func pal_swap_draw_palette(pal_sprite,pal_index,x,y);
function pal_swap_draw_palette(pal_sprite, pal_index, _x, _y)
{
	draw_sprite_part(pal_sprite, 0, pal_index, 0, 1, 
	sprite_get_height(pal_sprite), _x, _y);
}

///@func pal_swap_get_color_count(pal_sprite);
function pal_swap_get_color_count(_sprite) {
	return(sprite_get_height(_sprite));
}

///@dfunc pal_swap_get_pal_count(pal_sprite)
function pal_swap_get_pal_count(_sprite) {
	//returns the number of palettes for the given sprite.
	//Useful for clamping palette selection.
	return(sprite_get_width(_sprite));
}
