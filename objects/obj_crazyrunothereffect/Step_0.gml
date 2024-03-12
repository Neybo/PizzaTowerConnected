if REMIX_GAMEPLAY
{
	if !instance_exists(ovaries)
	{
		with instance_create(x, y, obj_cloudeffect)
		{
			depth = -99;
			sprite_index = spr_crazyrunothereffect_overlay;
			image_index = other.image_index;
			image_speed = 0.5;
			image_xscale = other.image_xscale;
		}
	}
}
else
	depth = -99;

if FINAL_GAMEPLAY
	exit;

image_xscale = playerid.xscale
if playerid.movespeed <= 12 && playerid.state != states.faceplant && playerid.state != states.chainsawbump
	instance_destroy()

