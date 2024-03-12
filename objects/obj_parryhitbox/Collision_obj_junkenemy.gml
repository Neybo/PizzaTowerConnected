with other.id
{
	var current_hspd = abs(hsp) * 0.8;
	var _dir = sign(hsp);
	if x != other.x
		_dir = sign(x - other.x);
	
	hsp = _dir * current_hspd;
	vsp = -6;
	
	rebound = true;
}
if !collisioned
	event_user(0);

