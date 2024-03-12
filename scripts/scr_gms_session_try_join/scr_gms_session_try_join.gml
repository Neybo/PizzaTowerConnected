function scr_gms_session_find_empty(session_type){
	for(var i = 0; i < gms_session_count(); i++)
	{
		var _id = gms_session_id(i)
	    if(gms_session_type(_id) == session_type) && gms_session_player_count(_id) == 0
	    {
	        return _id;
	    }
	}

	return -1;
}
function scr_gms_session_find_default()
{
	for(var i = 0; i < gms_session_count(); i++)
	{
		var _id = gms_session_id(i)
	    if(gms_session_type(_id) < 1)
	    {
	        return _id;
	    }
	}

}

function gms_load_start_room(sesid)
{
	global.default_session = gms_session_current_id()
	var p = gms_other_count()
	global.roommessage = string(p) + (p == 1 ? lang_string("online.playeronline") : lang_string("online.playersonline"));
	with obj_roomname
	{
		message = global.roommessage;
		showtext = true;
		alarm[0] = 200;
	}
	
	
	global.__script_session = -1
}