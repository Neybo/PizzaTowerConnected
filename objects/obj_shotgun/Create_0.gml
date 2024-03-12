ID = id;

image_speed = 0.35
hsp = 0
vsp = 0
grav = 0.5
grounded = false

depth = 10
if scr_depthcheck()
	depth += 100;

pickupimg = 0

with obj_player
	if character == "S" instance_destroy(other);

if obj_player.character == "N"
	sprite_index = spr_minigun;
else if obj_player.character == "PP"
	sprite_index = spr_coconutgun;
else if obj_player.character == "SP"
	sprite_index = spr_canecollect;
else
{
	if OLD_GAMEPLAY
		sprite_index = spr_shotgun
	else
		sprite_index = spr_shotgunNEW
}