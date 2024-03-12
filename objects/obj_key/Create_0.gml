
/*
if global.key_inv == true
{
vsp = -15
hsp = random_range(-4, 4)
}
*/

hsp = 0
vsp = 0

inv_frame = false

grav = 0.4
image_speed = 0.35

depth = 1
if scr_depthcheck()
	depth += 100;

if check_sugary()
	sprite_index = spr_key_ss;

