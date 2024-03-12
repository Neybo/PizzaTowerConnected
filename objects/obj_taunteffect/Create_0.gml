if performance_destroy()
	exit;

if global.gameplay = 0
	sprite_index = spr_taunteffect
else
	sprite_index = spr_taunteffectNEW

image_speed = 0.5
depth = 1
sugary = false
pissino = false

if check_online() && !check_bysync()
	alarm[0] = 1
player = obj_player

