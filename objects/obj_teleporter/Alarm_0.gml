if targetRoom == room
{
	with (obj_teleporter)
	{
		if trigger = other.trigger && start = 0 
		{
			player.x = x
			player.y = y - 20
			player.hitX = x
			player.hitY = y - 20
		}
	}

	alarm[1] = 10
	alarm[0] = -1
}
else
{
	alarm[0] = -1
	player.targetRoom = targetRoom;
	player.targetDoor = trigger;
	with player
		storedstate = states.jump
	instance_create(x,y,obj_fadeout);
}