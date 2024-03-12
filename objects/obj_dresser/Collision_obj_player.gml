var player = other;
if player.key_up2 && player.state == states.normal && !instance_exists(obj_choicebase)
{
	player.key_up2 = false;
	with instance_create(0, 0, obj_skinchoice)
	{
		playerid = player.id;
		
		noisetype = player.noisetype;
		sel = [player.paletteselect, player.character];
		event_user(0);
	}
}

