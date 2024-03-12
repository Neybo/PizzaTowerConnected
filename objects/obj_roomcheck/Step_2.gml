if nextroom
{		
	if room == room_last
	{
		room = Realtitlescreen
		instance_destroy(instance_find(obj_roomname, 1))
		pal_swap_init_system(shd_pal_swapper)
		instance_destroy()
		exit;
	}
	else if room_next(room) == room_of_dog
		room = room_next(room_of_dog)
	else if room_next(room) == rm_mario
		room = room_next(rm_darkreveal)
	else if room_next(room) == boss_room1
		room = room_next(boss_room1)
	else if room_next(room) == racing_results
		room = room_next(racing_results)
	else if room_next(room) == rm_rickroll
		room = room_next(rm_rickroll)
	else
		room = room_next(room)
}
else
	nextroom = true