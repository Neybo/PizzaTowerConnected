if instance_exists(obj_secretportal) || instance_exists(obj_secretportalstart)
	return;
	
with obj_player
{
	image_xscale = sign(image_xscale)
	scale_xs = sign(scale_xs)
	xscale = sign(xscale)

	image_yscale = sign(image_yscale)
	scale_ys = sign(scale_ys)
	yscale = sign(yscale)
}