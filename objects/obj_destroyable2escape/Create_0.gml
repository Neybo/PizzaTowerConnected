if obj_player.character == "N"
	sprite_index = spr_halloweensmallblockescape
else if obj_player.character == "SP"
{
	sprite_index = spr_destroyable2escape_ss
	if FINAL_GAMEPLAY
		sprite_index = spr_destroyable2escapeNEW_ss
}
else if obj_player.character == "PP"
	sprite_index = spr_destroyable21_PP

if !check_sugary() && FINAL_GAMEPLAY
	instance_destroy(id, false)

depth = 1
image_speed = 0.35;
image_index = random(image_number);

momentum = [0, 0];
