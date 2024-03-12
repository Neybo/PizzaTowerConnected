with other
{
	if scr_transformationcheck() && !grounded && state != states.stunned
	{
		state = states.bump
		hsp = 0
		vsp = 10
	}
}

