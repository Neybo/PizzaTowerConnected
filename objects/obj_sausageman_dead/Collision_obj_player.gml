if OLD_GAMEPLAY
	exit;

if buffer <= 0 && other.instakillmove
{
    vsp = random_range(-10, -18)
    hsp = sign(x - other.x) * random_range(10, 18)
    randomize()
    spinspeed = choose(0, 0, 0, 10, 20)
    instance_create(x, y, obj_bangeffect)
    buffer = 10
	
    if x != other.x
        image_xscale = -sign(x - other.x)
}
