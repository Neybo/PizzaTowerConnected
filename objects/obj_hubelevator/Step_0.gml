switch (categoryindex)
{
	case 0:
		hub_array = hub_array_0;
		break;
	case 1:
		hub_array = hub_array_1;
		break;
	case 2:
		hub_array = hub_array_2;
		break;
	case 3:
		hub_array = hub_array_3;
		break;
};
if (checkroom = false)
{
	switch (room)
	{
		case tower_1:
		case tower_2:
		case tower_3:
		case tower_4:
		case tower_5:
			categoryindex = 0;
			break;
		case hub_room1:
		case hub_room2:
		case rm_test:
		case PP_room1:
			categoryindex = 1;
			break;
		case hub_arcade:
		case hub_pvp:
		case hub_race:
		case hub_outsideAFK:
			categoryindex = 2;
			break;
		case hub_roomSP:
			categoryindex = 3;
			break;
		default:
			categoryindex = 0;
	};
	checkroom = true;
};
targetDoor = hub_array[sel][2];

if state == 1
{
	if obj_player.state != states.normal
		state = 0;
	else
	{
		scr_getinput(true);
		
		var move = -key_up2 + key_down2;
		var move2 = key_left2 + key_right2;
		if move != 0
		{
			var selprev = sel;
			sel = clamp(sel + move, 0, array_length(hub_array) - 1);
		
			if sel != selprev
				scr_soundeffect(sfx_step);
		}
		
		if move2 == -1
		{
			if categoryindex == 0
				categoryindex = (array_length(categories) - 1)
			else
				categoryindex -= 1;
			sel = 0
		}
		else if move2 == 1
		{
			if categoryindex == (array_length(categories) - 1)
				categoryindex = 0
			else
				categoryindex += 1;
			sel = 0
		}
		
		if key_jump
		{
			if (hub_array[sel][1] == PP_room1)
			&& (global.timeattack or global.modifier != -1)
				scr_soundeffect(sfx_denied);
			else
				state = 2;
		}
		else if key_slap2
		{
			scr_soundeffect(sfx_enemyprojectile);
			state = 0;
		}
	}
}

if state == 2
{
	obj_player.targetRoom = hub_array[sel][1];
	if obj_player.targetRoom != room
	{
		state = 3;
		scr_soundeffect(sfx_door)
	
		obj_camera.chargecamera = 0
		with obj_player
		{
			lastroom = room;
			sprite_index = spr_lookdoor;
		
			targetDoor = other.targetDoor;
			image_index = 0;
			state = states.door;
			mach2 = 0;
		}
		instance_create(x, y, obj_fadeout)
	}
	else
	{
		state = 0;
		obj_player.state = states.normal;
	}
}
if room == hub_pvp
{
	with obj_player
		visible = true
}
