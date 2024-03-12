draw_self()
if grounded && !scr_solid(x,y)
{
	pickupimg += 0.35;
	
	var yy = y;
	if sprite_index == spr_canecollect
		yy -= 12;
	if sprite_index == spr_shotgunNEW
		yy -= 8;
	if sprite_index == spr_shotgun
		yy -= 22;
	
	draw_sprite(spr_grabicon, pickupimg, x - 8, yy)
}

