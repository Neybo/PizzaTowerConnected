if sprite_index == obj_player.spr_portalenter // && !instance_exists(obj_fadeout)
{
	with obj_player
	{
		visible = true
		sprite_index = spr_portalexit
		image_index = 0
		targetRoom = other.targetRoom
		targetDoor = other.targetDoor
		instance_create(0, 0, obj_fadeout)
		visible = true
		if OLD_GAMEPLAY || scr_levelname() == "war" || scr_levelname() == "exit"
		{
			ds_list_clear(global.baddieroom)
			if scr_levelname() == "exit"
				ds_list_clear(global.saveroom);
		}
		ds_list_clear(global.escaperoom)
	}
}
