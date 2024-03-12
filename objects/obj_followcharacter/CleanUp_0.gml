var find = ds_list_find_index(global.followerlist, id);
if find != -1
{
	ds_list_delete(global.followerlist, find);
	with obj_followcharacter
	{
		pos = ds_list_find_index(global.followerlist, id);
		followid = (pos > 0 ? ds_list_find_value(global.followerlist, pos - 1) : noone);
	}
}

