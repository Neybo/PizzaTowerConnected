if performance_destroy()
	exit;

if global.gameplay = 0
	sprite_index = spr_cloudeffect
else
	sprite_index = spr_cloudeffectnew
depth = -6
image_speed = 0.5;