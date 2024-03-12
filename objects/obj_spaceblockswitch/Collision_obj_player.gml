if other.state == states.handstandjump 
|| (other.character == "S" && (other.state == states.freefall || other.state == states.freefallprep))
{
	event_user(0)
	scr_soundeffect(sfx_punch)
	with other
		scr_pummel()
}
