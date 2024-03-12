if ds_list_find_index(global.baddieroom, id) != -1
	instance_destroy();
else
	event_user(0);

// snap to ground

	for(i = y; i < y + 64; i++)
	{
		if scr_solid(x, i + 1)
		{
			y = i;
			break;
		}
	}


