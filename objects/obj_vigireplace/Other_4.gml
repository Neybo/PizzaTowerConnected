if in != noone && out != noone
{
	var checker = (character == "" && (obj_player.character == "V" or obj_player.character == "S")) or obj_player.character == character;
	if (!invert && checker) or (invert && !checker)
	{
		with in
		{
			var inid = id;
			if place_meeting(x, y, other)
			{
				if ds_list_find_index(global.saveroom, id) != -1
					event_perform(ev_other, ev_room_start);
				else
				{
					with instance_create(x, y, other.out)
						ID = inid;
					instance_destroy(id, false);
				}
			}
		}
	}
}
else
{
	show_debug_message("invalid obj_vigireplace in " + string(room_get_name(room)));
	instance_destroy();
}

