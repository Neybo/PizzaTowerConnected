var col = image_blend;
/*if room == hub_roomPLN
{
	var startgate = instance_place(x, y, obj_startgate);
	if !(startgate && startgate.image_index == 1)
		col = merge_colour(col, c_black, 0.4);
}*/

draw_sprite_ext(sprite_index, image_index, x, y + yoffset + yslope, xscale, image_yscale, image_angle, col, image_alpha);

