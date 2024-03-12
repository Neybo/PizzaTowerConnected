event_inherited();
image_speed = 0;

vsp = random_range(-4, 0);
hsp = random_range(-4, 4);

if FINAL_GAMEPLAY
{
	hsp = random_range(-5, 5);
	vsp = random_range(-10, 10);
}

grav = 0.4;
momentum = [hsp, vsp];
image_angle = irandom_range(0, 360);

depth = -1;
alarm[0] = 1;
