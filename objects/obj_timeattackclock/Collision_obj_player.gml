if other.state == states.handstandjump
or other.state == states.kungfu
{
	with other
		scr_pummel();
	
	event_user(0);
	
	if global.timeattack
		scr_soundeffect(sfx_killingblow);
}