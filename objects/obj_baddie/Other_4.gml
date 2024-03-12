var list = escape ? global.escaperoom : global.baddieroom;
if ds_list_find_index(list, id) != -1
	instance_destroy(id, false);
else
	event_user(0);

if elite && FINAL_GAMEPLAY
{
    hp += 1
    elitehp = hp
}

// snap to ground
	for(i = y; i < y + 64; i++)
	{
		if scr_solid(x, i + 1)
		{
			y = i;
			break;
		}
	}


if (global.lap >= 5)
{
	hp = round(min(round(hp * (0.3 * global.lap)), 8))
	if (elite)
		elitehp = hp
}
if (global.lap >= 99)
{
	hp = 10
	elite = true
}