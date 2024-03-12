event_inherited()
if playerid.state != states.backbreaker
{
	if x != xprevious or y != yprevious
		sprite_index = spr_run
	else
		sprite_index = spr_idle
}
else
	sprite_index = spr_pose

if sprite_index == spr_run && scr_solid(x, y + 1) && visible
	steppy--

if steppy <= 0
{
	instance_create(x, bbox_bottom, obj_cloudeffect)
	steppy = 20
}
if xprevious - x != 0
	xscale = -sign(xprevious - x)
else if playerid.hsp == 0
	xscale = playerid.xscale

if dir != playerid.xscale
	dir = playerid.xscale

