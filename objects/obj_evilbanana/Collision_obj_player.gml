if grounded
{
	other.state = states.normal
	other.sprite_index = other.spr_mach3boost
	other.state = states.slipnslide
	instance_destroy();
}