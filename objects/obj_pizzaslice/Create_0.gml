image_speed = 0.5
hsp = 0
vsp = random_range(-2, -4)
grav = 0.5

switch obj_player.character
{
	case "N": sprite_index = spr_halloweenspinningpizza; break;
	case "S": sprite_index = spr_snickcollectible2; image_speed = 0.35; break;
	case "SP": sprite_index = spr_pizzaslice_ss; break;
	case "PP": sprite_index = spr_pizzaslice_PP; break;
}

if string_startswith(room_get_name(room), "strongcold")
	sprite_index = spr_xmasspinningslice;
if global.snickrematch
	sprite_index = spr_pizzaslice_re

if sprite_index == spr_snickcollectible2
	mask_index = spr_snickcollectible2
