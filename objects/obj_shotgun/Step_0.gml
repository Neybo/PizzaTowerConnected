scr_collide()

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