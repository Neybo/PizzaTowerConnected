hsp = spd * image_xscale
x += hsp
y += vsp

if scr_solid(x, y)
	instance_destroy()
