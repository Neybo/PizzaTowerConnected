global.breaksound = 0
depth = 1

if check_sugary()
{
	sprite_index = spr_destroyableescape_ss
	if FINAL_GAMEPLAY
		sprite_index = spr_destroyableescapeNEW_ss
}
else if FINAL_GAMEPLAY
	instance_destroy(id, false)

momentum = [0, 0];
