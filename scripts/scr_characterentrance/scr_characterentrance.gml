function scr_characterentrance()
{
	// entrance
	var roomname = room_get_name(room)
	if string_letters(roomname) == "entrance"
	or string_letters(roomname) == "entryway"
	{
		with obj_music
			alarm[1] = 1;
	}
}

