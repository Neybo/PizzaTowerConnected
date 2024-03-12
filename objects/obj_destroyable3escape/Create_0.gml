event_inherited()
depth = 1

if check_sugary()
{
	sprite_index = spr_bigdestroyableescape_ss
	if FINAL_GAMEPLAY
		sprite_index = spr_bigdestroyableescapeNEW_ss
}
else if FINAL_GAMEPLAY
	instance_destroy(id, false);

momentum = [0, 0];
