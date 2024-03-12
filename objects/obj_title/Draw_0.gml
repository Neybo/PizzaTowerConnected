// menu light
/*
if object_index == obj_title
{
	draw_set_colour(#F8D0D0);
	draw_triangle(obj_player.x - 100, room_height, obj_player.x + 100, room_height, room_width / 2, -270, false);
}
*/

// draw self
draw_sprite_ext(sprite_index, 0, round(x), round(y), image_xscale, image_yscale, image_angle, image_blend, image_alpha);

