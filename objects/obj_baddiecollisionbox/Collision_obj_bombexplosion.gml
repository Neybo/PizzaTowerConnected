if instance_exists(baddieID) && baddieID.state != states.grabbed && baddieID.state != states.stun && baddieID.state != states.hit
{
	with baddieID
	{
		state = states.stun	
		stunned = 150
		vsp = -5
	}
}

