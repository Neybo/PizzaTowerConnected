if check_online()
{
	var p = gms_other_count();
	global.roommessage = string(p) + (p == 1 ? lang_string("online.playeronline") : lang_string("online.playersonline"));
}
else
	global.roommessage = lang_string("roomname.hub_roomSAGE");

