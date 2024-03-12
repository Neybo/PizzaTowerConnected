x += hsp
y += vsp

if scr_solid(x, y)
{
	instance_create(x + 20 * image_xscale, y + 15, obj_bumpeffect)
	instance_destroy()
}

