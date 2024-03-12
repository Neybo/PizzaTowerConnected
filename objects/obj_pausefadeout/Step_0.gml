if !instance_exists(obj_pause)
{
	instance_destroy();
	exit;
}

if fadealpha >= 1 && !fadein
{
	if obj_pause.pause
	{
		// unpause
		fmod_resume_all();
				
		global.minichat = global.minichatstore
				
		obj_pause.pause = false;
		obj_pause.pausefad = 2;
		obj_pause.pausealpha = 1;
		
		
		if sprite_exists(obj_pause.pausebg)
			sprite_delete(obj_pause.pausebg);
			
		while !instance_exists(obj_player)
			instance_activate_object(obj_player)
		with obj_player
			scr_playersounds_refresh()
			
		while true
		{
			_act = array_pop(obj_pause.objectlist);
			if _act == undefined
				break;
			instance_activate_object(_act);
		}
	
		alarm[0] = 1
	}
	else
	{
		// pause
		fmod_pause_all_except_one(global.jukebox)
		
		with obj_pause
		{
			pause = true;
			pausefad = 1;
			pausealpha = 0;
			
			with obj_player
			{
				other.character = character;
				other.paletteselect = paletteselect;
			}
		}
		
		with all
		{
			if object_index != obj_pause && object_index != obj_otherplayer && object_index != obj_gms
			&& object_index != obj_wc && object_index != obj_inputdisplay 
			&& object_index != obj_controller && object_index != obj_global
			&& id != other.id && object_index != obj_player && object_index != obj_fadeout
			&& object_index != obj_fmod
			{
				array_push(obj_pause.objectlist, id);
				instance_deactivate_object(id);
			}
			if object_index == obj_fadeout
				instance_destroy();
		}
		while instance_exists(obj_player)
			instance_deactivate_object(obj_player)
		
		global.__chat = false;
	}
	
	fadein = true;
}

if !fadein
	fadealpha += 0.1;
else
{
	fadealpha -= 0.1;
	if alarm[0] <= -1
		instance_destroy();
}

