if state != states.cherrywait
{
	groundpound = true;
	event_inherited();
	
	var b = instance_place(x, y, obj_baddiecollisionbox);
	if instance_exists(b) && b.baddieID.state == states.stun && b.baddieID.thrown
		instance_destroy();
}
