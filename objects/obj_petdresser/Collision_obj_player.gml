var player = other;
if player.key_up2 && player.state == states.normal && !instance_exists(obj_choicebase)
{
	with instance_create(0, 0, obj_petchoice)
	{
		playerid = player.id;
		sel[0] = player.petfollow + 1;
		event_user(0);
	}
}

