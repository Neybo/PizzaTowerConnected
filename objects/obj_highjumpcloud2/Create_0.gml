if performance_destroy()
	exit;

if global.gameplay = 0
	sprite_index = spr_highjumpcloud2
else
	sprite_index = spr_highjumpcloud2NEW

image_speed = 0.5
image_xscale = obj_player.xscale

