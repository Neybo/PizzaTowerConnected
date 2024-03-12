if other.vsp > 0 && !other.cutscene
{
	
	sprite_index = spr_bounce;
	image_index = 0;
	
	other.endtumble = true;
	if other.state == states.freefall || other.state == states.freefallprep
		other.state = states.normal
	
	if other.state == states.jump or other.state == states.normal
		other.sprite_index = other.spr_machfreefall;
	
	other.y--
	other.vsp = sugary ? -24 : -20
	other.jumpstop = true
	if other.state == states.machslide
		other.grounded = true // prevent softlock
}
