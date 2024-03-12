repeat 3
	with instance_create(x + irandom_range(-16, 16), y + irandom_range(-16, 16), obj_debris)
		sprite_index = spr_rockdebris;
instance_create(x, y, obj_cloudeffect);

