if !visible
	exit;
with other
{
	if state == states.handstandjump or state == states.punch
	{
		if !instance_exists(obj_cafe_time)
			instance_create(0,0, obj_cafe_time)
		state =	states.dogmount		
		sprite_index = spr_rideweenie
		xscale = other.image_xscale
		jumpstop = true
		movespeed = 0
		grounded = false
	}
}