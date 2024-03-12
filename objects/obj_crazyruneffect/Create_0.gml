if performance_destroy()
	exit;

playerid = obj_player

if global.gameplay = 0
	sprite_index = spr_crazyruneffect
else
	sprite_index = spr_crazyruneffectNEW

image_speed = 0.5
image_xscale = playerid.xscale

depth = -10