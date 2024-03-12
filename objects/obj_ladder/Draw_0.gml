if image_yscale > 1 && autotile
{
	draw_sprite(sprite_index, place_meeting(x, y - 1, obj_solid) ? 0 : 2, x, y);
	draw_sprite(sprite_index, place_meeting(x, y + 1, obj_solid) ? 0 : 1, x, y + 32 * (image_yscale - 1));
	if image_yscale > 2
		draw_sprite_ext(sprite_index, 0, x, y + 32, image_xscale, image_yscale - 2, 0, c_white, 1);
}
else
	draw_self();
