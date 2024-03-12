instance_activate_object(obj_roomname);
if async_load[?"event_type"] == "gamepad discovered"
{
	var ind = async_load[?"pad_index"];
	if global.cont != ind
	{
		with obj_roomname
		{
			message = "USING GAMEPAD " + string(ind);
			showtext = true;
			alarm[0] = room_speed;
		}
		global.cont = ind;
		
		connected = true;
		scr_soundeffect(sfx_contin);
	}
}
if async_load[?"event_type"] == "gamepad lost"
{
	var pad = async_load[?"pad_index"];
	if global.cont == pad
	{
		with obj_roomname
		{
			message = "GAMEPAD " + string(pad) + " OUT";
			showtext = true;
			alarm[0] = room_speed * 2;
		}
		global.cont = -1;
	}
	else
	{
		scr_soundeffect(sfx_contout);
		exit;
	}
	
	// show disconnected controller screen
	fmod_pause_all();
	scr_soundeffect(sfx_contout);
	
	onpause = false;
	if instance_exists(obj_pause) && obj_pause.pause
		onpause = true;
	
	if !onpause
		pausebg = sprite_create_from_surface(application_surface, 0, 0, surface_get_width(application_surface), surface_get_height(application_surface), false, false, 0, 0);
	disconnected = true;
	
	if check_online()
		gms_self_set("pause", true);
	
	with all
	{
		if object_index != obj_roomname && object_index != obj_wc
		&& id != other.id
		{
			array_push(other.instlist, id);
			instance_deactivate_object(id);
		}
	}
}

