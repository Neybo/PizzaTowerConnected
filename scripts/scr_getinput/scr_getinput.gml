function scr_getinput(force = false, extra = false)
{
	with obj_player
		online_busy = false;
	
	if (instance_exists(obj_minesweeper) or  
	instance_exists(obj_option)
	or (instance_exists(obj_gms) && global.__chat)
	or (safe_get(obj_manual, "open")) // ?
	or (instance_exists(obj_wc) && (obj_wc.WC_consoleopen || obj_wc.WC_assetfinder > -1))
	or (instance_exists(obj_shell) && obj_shell.isOpen)
	or (instance_exists(obj_choicebase))
	or (instance_exists(obj_hubelevator) && obj_hubelevator.state == 1)
	or instance_exists(obj_arcademenu)
	or instance_exists(obj_dialoguebox)
	or instance_exists(obj_tvvideo) && obj_tvvideo.opened)
	{
		with obj_player
			online_busy = true;
		
		if !force
		{
			key_up = false
			key_up2 = false
			key_right = false
			key_right2 = false
			key_left = false
			key_left2 = false
			key_down = false
			key_down2 = false
			key_jump = false
			key_jump2 = false
			key_slap = false
			key_slap2 = false
			key_taunt = false
			key_taunt2 =  false
			key_attack = false
			key_attack2 = false
			key_shoot = false
			key_shoot2 = false
			key_start = false
			key_escape = false
			key_chainsaw = false
			key_chainsaw2 = false
			key_extra = false
			key_extra2 = false
		
			stickpressed = true;
			exit;
		}
	}
	
	if !variable_instance_exists(id, "stickpressed")
		stickpressed = true;
	
	key_up = keyboard_check(global.key_up)
	key_up2 = keyboard_check_pressed(global.key_up)
	key_right = keyboard_check(global.key_right)
	key_right2 = keyboard_check_pressed(global.key_right)
	key_left = -keyboard_check(global.key_left)
	key_left2 = -keyboard_check_pressed(global.key_left)
	key_down = keyboard_check(global.key_down)
	key_down2 = keyboard_check_pressed(global.key_down)
	key_jump = keyboard_check_pressed(global.key_jump)
	key_jump2 = keyboard_check(global.key_jump)
	key_slap = keyboard_check(global.key_slap)
	key_slap2 = keyboard_check_pressed(global.key_slap)
	key_taunt = keyboard_check(global.key_taunt)
	key_taunt2 =  keyboard_check_pressed(global.key_taunt)
	key_attack = keyboard_check(global.key_attack)
	key_attack2 = keyboard_check_pressed(global.key_attack)
	if extra
	{
		key_shoot = keyboard_check(global.key_shoot)
		key_shoot2 = keyboard_check_pressed(global.key_shoot)
		key_chainsaw = keyboard_check(global.key_chainsaw)
		key_chainsaw2 = keyboard_check_pressed(global.key_chainsaw)
		key_extra = keyboard_check(global.key_extra)
		key_extra2 = keyboard_check_pressed(global.key_extra)
	}
	key_start = keyboard_check_pressed(global.key_start)
	key_escape = keyboard_check_pressed(vk_escape)

	var cont = global.cont;
	
	// gamepad
	if cont > -1
	{
		var deadzone = 0.4
		gamepad_set_axis_deadzone(cont, deadzone)
		
		#region movement controller
			key_up |= gamepad_button_check(cont, global.key_upC) 
			or gamepad_axis_value(cont, gp_axislv) < 0;
		
			key_up2 |= gamepad_button_check_pressed(cont, global.key_upC) 
			or (gamepad_axis_value(cont, gp_axislv) < -deadzone && !stickpressed);
		
			key_right |= gamepad_button_check(cont, global.key_rightC)  
			or gamepad_axis_value(cont, gp_axislh) > 0;
		
			key_right2 |= gamepad_button_check_pressed(cont, global.key_rightC) 
			or (gamepad_axis_value(cont, gp_axislh) > deadzone && !stickpressed);
		
			key_left |= -(gamepad_button_check(cont, global.key_leftC) 
			or gamepad_axis_value(cont, gp_axislh) < 0);
		
			key_left2 |= -(gamepad_button_check_pressed(cont, global.key_leftC) 
			or (gamepad_axis_value(cont, gp_axislh) < -deadzone && !stickpressed));
		
			key_down |= gamepad_button_check(cont, global.key_downC) 
			or gamepad_axis_value(cont, gp_axislv) > 0;
		
			key_down2 |= gamepad_button_check_pressed(cont, global.key_downC) 
			or (gamepad_axis_value(cont, gp_axislv) > deadzone && !stickpressed);
		#endregion
		
		key_jump |= gamepad_button_check_pressed(cont, global.key_jumpC);
		key_jump2 |= gamepad_button_check(cont, global.key_jumpC);
		key_slap |= gamepad_button_check(cont, global.key_slapC);
		key_slap2 |= gamepad_button_check_pressed(cont, global.key_slapC)
		key_taunt |= gamepad_button_check(cont, global.key_tauntC)
		key_taunt2 |=  gamepad_button_check_pressed(cont, global.key_tauntC)
		key_attack |= gamepad_button_check(cont, global.key_attackC) 
		key_attack2 |= gamepad_button_check_pressed(cont, global.key_attackC)
		if extra
		{
			key_shoot |= gamepad_button_check(cont, global.key_shootC) 
			key_shoot2 |= gamepad_button_check_pressed(cont, global.key_shootC) 
			key_chainsaw |= gamepad_button_check(cont, global.key_chainsawC) 
			key_chainsaw2 |= gamepad_button_check_pressed(cont, global.key_chainsawC) 
			key_extra |= gamepad_button_check(cont, global.key_extraC) 
			key_extra2 |= gamepad_button_check_pressed(cont, global.key_extraC) 
		}
		key_start |= gamepad_button_check_pressed(cont, global.key_startC) 
		key_escape |= gamepad_button_check(cont, gp_select)
		
		if (gamepad_axis_value(cont, gp_axislh) > deadzone 
		or gamepad_axis_value(cont, gp_axislh) < -deadzone)
		or (gamepad_axis_value(cont, gp_axislv) > deadzone 
		or gamepad_axis_value(cont, gp_axislv) < -deadzone)
			stickpressed = true;
		else
			stickpressed = false;
	}
	else
		stickpressed = true;
}

