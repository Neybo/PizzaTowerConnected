event_inherited()
image_speed = 0.1
playerid = obj_player
yoffset = 0

toppinwarrior = 1
set = false
canattack = false

global.toppinwarriorattackcountdown = 0
global.toppinwarriorturn = 1

space = 0
dir = playerid.xscale

steppy = 20
mask_index = spr_player_mask
depth = -5

if OLD_GAMEPLAY
{
	repeat 6 with instance_create(x + random_range(-50, 50), y + random_range(-50, 50), obj_cloudeffect)
		sprite_index = spr_baddiespawn
}
else
	instance_create(x, y, obj_genericpoofeffect);

