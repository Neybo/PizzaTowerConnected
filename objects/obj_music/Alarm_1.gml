/// @description restart music
with obj_player
{
	if state == states.victory && place_meeting(x, y, obj_startgate)
		exit;
}
event_perform(ev_other, ev_room_start);

