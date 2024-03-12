if flip_on_panic && global.panic && !turned
{
	image_xscale *= -1
	turned = true
}
if sprite_index != spr_dashpad_ss
	scr_collide();

