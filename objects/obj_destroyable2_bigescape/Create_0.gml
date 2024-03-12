event_inherited()
if obj_player.character == "N"
	sprite_index = spr_halloweenbigblockescape
else if obj_player.character == "SP"
{
	sprite_index = spr_destroyable2bigescape_ss
	if FINAL_GAMEPLAY
		sprite_index = spr_destroyable2bigescapeNEW_ss
}
else if obj_player.character == "PP"
	sprite_index = spr_bigbreakableescape_PP

if !check_sugary() && FINAL_GAMEPLAY
	instance_destroy(id, false);

depth = 1
content = noone
image_speed = 0.35;
image_index = random(image_number);

momentum = [0, 0];

