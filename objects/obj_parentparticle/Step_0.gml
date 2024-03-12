if vsp < 12
	vsp += grav;

image_speed = 0;

x += hsp;
y += floor(vsp);

if y >= room_height + 64
	instance_destroy();

