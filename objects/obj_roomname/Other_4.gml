var msg = global.langmap[? "roomname." + room_get_name(room)];
if is_undefined(msg) or room == hub_room1
	msg = global.roommessage;
msg = string(msg);

if room != rank_room && room != timesuproom && room != Realtitlescreen
{
	if !ds_list_find_index(seenlist, room)
	{
		//if REMIX_GAMEPLAY
		//	ds_list_add(seenlist, room);
		if msg != ""
		{
			message = msg;
			showtext = true;
			alarm[0] = 200;
		}
	}
}
else
{
	yi = -50;
	showtext = false;
}

with obj_drpc_updater
	roomname = msg;
global.roommessage = "";

