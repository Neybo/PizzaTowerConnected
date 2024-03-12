depth = -10;
image_speed = 0.35;
image_alpha = 0.4;

if check_sugary()
{
	sprite_index = spr_water_ss;
	image_alpha = 0.8;
}
else
	sprite_index = spr_water;
