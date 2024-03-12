/// @description teleport player
var keeptrying = false;
try
{
	with obj_otherplayer
		if player_id == other.__user keeptrying = true;
}

if keeptrying
{
	var xx = gms_other_get_real(__user, "x");
	var yy = gms_other_get_real(__user, "y");
	var rm = gms_other_get_real(__user, "room");
	
	if !(xx == 0 && yy == 0)
	{
		obj_player.state = states.normal;
		obj_player.targetDoor = "none";
		obj_player.x = xx;
		obj_player.y = yy;
		room_goto_new(rm);
	}
	else
		alarm[0] = 5;
}