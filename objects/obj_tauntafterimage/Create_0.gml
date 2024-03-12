if performance_destroy()
	exit;

image_speed = 0.5

image_xscale = obj_player.xscale
sprite_index = spr_supercharge

if obj_player.character == "S" or obj_player.character == "PP"
{
	image_speed = 0;
	sprite_index = obj_player.sprite_index;
	image_index = obj_player.image_index;
	
	randomize()
	image_blend = choose(make_colour_rgb(96, 208, 72), make_colour_rgb(248, 0, 0))
}

alarm[1] = 3
