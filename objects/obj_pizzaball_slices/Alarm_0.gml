count--;
with instance_create(obj_player.x, obj_player.bbox_top - 32, obj_pizzaslice)
{
	vsp = random_range(-3, -9)
	if OLD_GAMEPLAY
		hsp = choose(-2, 2);
	
	if scr_solid(x, y)
		y = obj_player.y;
}

if count <= 0
	instance_destroy();
else
	alarm[0] = spd;

