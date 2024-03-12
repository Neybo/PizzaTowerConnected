/// @description hit
shake = 5;
if hp == 1
	sprite_index = spr_bigdestroyable_ss

scr_soundeffect(sfx_breakblock)

with instance_create(x + sprite_width / 2, y + sprite_height / 2, obj_debris)
{
	sprite_index = spr_bigdebrisbandage_ss
	momentum = other.momentum
}
repeat 4
{
	with instance_create(x + sprite_width / 2, y + sprite_height / 2, obj_debris)
		sprite_index = spr_debris_ss
}

