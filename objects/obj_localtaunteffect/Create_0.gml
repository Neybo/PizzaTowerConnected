if performance_destroy()
	exit;

if global.gameplay = 0
	sprite_index = spr_taunteffect
else
	sprite_index = spr_taunteffectNEW

image_speed = 0.5
depth = 60