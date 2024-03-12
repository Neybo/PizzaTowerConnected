if ds_list_find_index(global.saveroom, id) != -1  
	instance_destroy()

// snap to ground
for(var i = 0; i < 16; i++)
{
	if scr_solid(x, y + i + 1)
	{
		y += i;
		break;
	}
}

