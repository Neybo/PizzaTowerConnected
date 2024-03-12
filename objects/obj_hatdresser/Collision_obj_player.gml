var player = other;
if player.key_up2 && player.state == states.normal && !instance_exists(obj_choicebase)
{
	with instance_create(0, 0, obj_hatchoice)
	{
		playerid = player.id;
		
		// auto select current hat
		if player.hatsprite != -1
		{
			for(var i = 0; i < array_length(selarray); i++)
			{
				if selarray[i][0] == player.hatsprite
				{
					sel[0] = i;
					event_user(0);
					break;
				}
			}
		}
	}
}

