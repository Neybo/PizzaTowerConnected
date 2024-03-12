function scr_gms_room(r = room)
{
		// merge old with new rooms (may show players inside walls with gameplay difference, but...)
		var rname = room_get_name(r);
		
		if string_endswith(rname, "_NEW")
			r = asset_get_index(string_replace(rname, "_NEW", ""));
		if r == -1
			r = room;
		
		return r;
}

