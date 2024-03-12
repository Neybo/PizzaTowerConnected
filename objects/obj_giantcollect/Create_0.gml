image_speed = 0.35

if instance_exists(obj_player)
{
	if obj_player.character == "N"
		sprite_index = spr_giantpizzahalloween
	if obj_player.character == "S"
		sprite_index = spr_snickcollectible3
	if obj_player.character == "SP"
	{
		sprite_index = spr_giantpizza_ss
		if FINAL_GAMEPLAY
			sprite_index = choose(spr_giantcollect1_ss, spr_giantcollect2_ss, spr_giantcollect3_ss, spr_giantcollect4_ss);
	}
	if obj_player.character == "PP"
		sprite_index = spr_giantpizza_PP
}

if global.snickrematch
	sprite_index = spr_giantpizza_re

depth = 4
if scr_depthcheck()
	depth += 100;
