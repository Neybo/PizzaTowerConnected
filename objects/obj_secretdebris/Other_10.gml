/// @description draw

// UNOWN > Stolen Angle Code thing
var sprite_diagonal = sqrt(sprite_height * sprite_height + sprite_width * sprite_width);
var dir = point_direction(x, y, x - sprite_get_xoffset(sprite_index),
y - sprite_get_yoffset(sprite_index))
var drawx = (x - sprite_xoffset) + lengthdir_x(sprite_diagonal / 2, image_angle + dir);
var drawy = (y - sprite_yoffset) + lengthdir_y(sprite_diagonal / 2, image_angle + dir);
draw_surface_ext(s, drawx + sprite_get_xoffset(sprite_index),
drawy + sprite_get_yoffset(sprite_index), image_xscale, image_yscale, image_angle,
c_white, image_alpha)





















