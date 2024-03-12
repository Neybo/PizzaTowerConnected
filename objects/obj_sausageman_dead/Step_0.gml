if hsp == 0
{
	if instance_exists(obj_player)
	{
		var sig = sign(x - obj_player.x);
		if sig == 0
			sig = obj_player.xscale;
	}
	else
		sig = 1;
	
	if OLD_GAMEPLAY
		hsp = sig * random_range(5, 10);
	else
		hsp = sig * random_range(10, 18);
}
image_xscale = -sign(hsp);

if vsp < 20
	vsp += grav;

x += hsp;
y += floor(vsp);

if sugary
	image_angle += spinspeed * image_xscale;

if buffer > 0
    buffer--
if d > 150
    d -= 20
if scream != FMOD_EMPTY
{
	fmod_set_event_3d_position(scream, x, y)
}