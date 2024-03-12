if ds_map_find_value(async_load, "id") == req
{
	if ds_map_find_value(async_load, "status") == 0
	{
		str = ds_map_find_value(async_load, "result");
		
		if (string_contains(str, "Hmm") || string_contains(str, "Unable") || string_contains(str, "We")
		|| string_contains(str, "Run"))
		{
			str = lang_string("disclaimer.error");
			if current_year >= 2024 || debug || !release // repls going down :(
			{
				event_user(2)
			}
			exit;
		}
		
		if (real(ds_list_find_value(string_split(str, ";"), 0)))
		{
			event_user(2)
		}
		else
		{
			str = lang_string("disclaimer.outdated") + " "
			+ ds_list_find_value(string_split(str, ";"), 1)
		}
	}
	else
	{
		str = lang_string("disclaimer.error");
		if current_year >= 2024 || debug || !release // repls going down :(
		{
			event_user(2)
		}
	}
	event_user(1);
}