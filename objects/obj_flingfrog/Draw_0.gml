draw_sprite_ext(sprite_index, -1, x + random_range(-shake, shake), y + random_range(-shake, shake), image_xscale, image_yscale, image_angle, image_blend, image_alpha);

handsimg += 0.35;
draw_sprite_ext(playerid == noone ? spr_flingfrog_handsidle : spr_flingfrog_handsmove, handsimg, handsx, handsy - 50, 1, 1, 0, c_white, 1);

if playerid == noone
	draw_sprite_ext(spr_flingfroggrab, handsimg, handsx, handsy, 1, 1, 0, c_white, 1);
else if tired > 10
	draw_sprite_ext(spr_flingfrogmadtire, -1, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);

