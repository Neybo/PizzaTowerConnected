if performance_destroy()
	exit;

image_speed = 0.35
if global.gameplay = 0
	sprite_index = spr_angrycloud
else
	sprite_index = spr_angrycloudNEW

playerid = obj_player
image_xscale = playerid.xscale
x = playerid.x
y = playerid.y
