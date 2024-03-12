if scr_solid(x + ceil(hsp) + sign(hsp), y)
	hsp *= -1
x += frac(hsp)

scr_collide();
if scr_solid(x, y + vsp + 1) && vsp >= 0 && bounce > 0
{
	gr = true
	vsp = -bounce
	bounce = floor(bounce / 1.5)
}

if grounded && hsp != 0
	hsp = max(abs(hsp) - 0.05, 0) * sign(hsp);

if alarm[0] < 120 && alarm[0] % 4 == 0
	image_alpha = abs(1 - image_alpha)

if y >= room_height + 64
	instance_destroy();

