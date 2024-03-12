if (!global.notgonnasugarcoatit)
	instance_destroy()
image_alpha = 0.9
scr_soundeffect(sfx_sugarcoat)
depth = -9999
x = 480
y = 270

image_speed = 0
switch obj_player.character
{
	default: 
		image_index = 0
		break;
	case "N":
		image_index = 1
		break;
	case "V":
		image_index = 2
		break;
	case "S":
		image_index = 3
		break;
	case "PP":
		image_index = 4
		break;
	case "SP":
		image_index = 5
		break;
	/*case "PUFFER":
		image_index = 6
		break;*/
}

with obj_player
	fmod_stop_instance_immediately(tauntsnd)