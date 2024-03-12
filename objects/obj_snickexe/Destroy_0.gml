repeat 6 with instance_create(x + random_range(-100, 100), y + random_range(-100, 100), obj_balloonpop)
	sprite_index = spr_shotgunimpact;

if global.snickchallenge && global.snickrematch && !instance_exists(obj_endlevelfade)
{
	// hydra from greek mythology
	with instance_create(x, y, obj_troller)
		snick = other.object_index;
}

