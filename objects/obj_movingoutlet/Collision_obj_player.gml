if string_startswith(room_get_name(room), "oldmansion")
{
	with other
	{
		if scr_transfobump()
			exit;
	}
}
scr_hurtplayer(other);

