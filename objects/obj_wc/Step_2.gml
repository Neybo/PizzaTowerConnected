/// @description world control mod

// pt online exclusive
if instance_exists(obj_login)
or (instance_exists(obj_gms) && global.__chat)
//or safe_get(obj_shell, "isOpen")
	exit;

if !debug
{
	//instance_destroy();
	//exit;
}

// funny variables
var tempobj, tempvar, temparray, tempind, tempval, tempscript, temp_objfind, frz, i, scrarg;

WC_mx = device_mouse_x_to_gui(0);
WC_my = device_mouse_y_to_gui(0);

// set depth
if depth == 0
	depth = power(2, 31) - 1;

// console open
if WC_consoleopen
{
	// control
	if keyboard_check(vk_control)
	{
		// paste
		if keyboard_check_pressed(ord("V")) && clipboard_has_text()
			keyboard_string += clipboard_get_text();
		
		// copy
		if keyboard_check_pressed(ord("C")) && string_replace_all(keyboard_string, " ", "") != ""
		{
			clipboard_set_text(keyboard_string);
			console_log("Copied command to clipboard");
			keyboard_string = "";
		}
		
		// delete all
		if keyboard_check_pressed(vk_backspace)
			keyboard_string = "";
	}
	
	// command history
	if keyboard_check_pressed(vk_up) && ds_list_size(WC_lastconsoleenter) != 0
	{
		// previous command
		WC_lastconsoleenterind = max(WC_lastconsoleenterind - 1, 0);
		keyboard_string = ds_list_find_value(WC_lastconsoleenter, WC_lastconsoleenterind);
	}
	if keyboard_check_pressed(vk_down) && ds_list_size(WC_lastconsoleenter) != 0
	{
		// more recent commands
		WC_lastconsoleenterind += 1;
		if WC_lastconsoleenterind > ds_list_size(WC_lastconsoleenter) - 1
		{
			WC_lastconsoleenterind = ds_list_size(WC_lastconsoleenter);
			keyboard_string = "";
		}
		else
			keyboard_string = ds_list_find_value(WC_lastconsoleenter, WC_lastconsoleenterind);
	}
	
	if keyboard_string != ds_list_find_value(WC_lastconsoleenter, WC_lastconsoleenterind)
	&& ds_list_size(WC_lastconsoleenter) != 0
		WC_lastconsoleenterind = ds_list_size(WC_lastconsoleenter);
	
	// expand console
	if WC_consolebottom < WC_maxconsolebottom
	{
		WC_consolebottom += WC_maxconsolebottom / 10;
		WC_consolebottom = min(WC_consolebottom, WC_maxconsolebottom);
	}
	if WC_consolebottom > WC_maxconsolebottom
	{
		WC_consolebottom -= 20;
		WC_consolebottom = max(WC_consolebottom, WC_maxconsolebottom);
	}
	
	// scroll
	if WC_my <= WC_maxconsolebottom
	{
		if mouse_wheel_up()
			WC_consolescroll += 1;
		if mouse_wheel_down()
			WC_consolescroll -= 1;
		WC_consolescroll = clamp(WC_consolescroll, 0, ds_list_size(WC_consolelist));
	}
	
	// line
	WC_drawlinetimer -= 1;
	if WC_drawlinetimer <= 0
	{
		WC_drawline = !WC_drawline;
		WC_drawlinetimer = 30;
	}
	
	if WC_consoletext != keyboard_string
	{
		WC_drawline = true;
		WC_drawlinetimer = 60;
	}
	
	// type on the console
	WC_consoletext = keyboard_string;
	if keyboard_check_pressed(vk_return)
	{
		WC_consoleenter = WC_consoletext;
		keyboard_string = "";
		WC_consoletext = "";
	}
}
else if ds_list_size(WC_bindkey) != 0 && WC_assetfinder < 0 // press binds
{
	for (i = 0; i < ds_list_size(WC_bindkey); i++)
	{
		if keyboard_check_pressed(ds_list_find_value(WC_bindkey, i))
			scr_wcevaluate(ds_list_find_value(WC_bindmap, i));
	}
}

// console not open
if !WC_consoleopen
{
	WC_lastconsoleenterind = ds_list_size(WC_lastconsoleenter);
	WC_consolebottom = 0;
	
	if WC_assetfinder == -1
		WC_consolescroll = 0;
}

// open console
if keyboard_check_pressed(vk_f5) && !WC_creatingobj && !WC_selectobj && WC_assetfinder < 0
{
	WC_consoleenter = "";
	WC_consoleopen = !WC_consoleopen;
	keyboard_string = "";
	WC_consoletext = "";
}

// console handler
if WC_consoleenter != ""
{
	if !WC_consolesilence && WC_consoleopen
		console_log("%..." + WC_consoleenter);
	
	if string_replace_all(WC_consoleenter, " ", "") != ""
	{
		// add to command history
		if !WC_consolesilence && WC_consoleopen
		{
			var alreadylogged = ds_list_find_index(WC_lastconsoleenter, WC_consoleenter);
			if alreadylogged != -1
				ds_list_delete(WC_lastconsoleenter, alreadylogged);
			ds_list_add(WC_lastconsoleenter, WC_consoleenter);
			WC_lastconsoleenterind = ds_list_size(WC_lastconsoleenter);
		}
		
		scr_wcevaluate(WC_consoleenter);
	}
	WC_consoleenter = "";
	WC_consolesilence = false;
}

// max size for console log
while ds_list_size(WC_consolelist) > power(2, 31) - 1
	ds_list_delete(WC_consolelist, power(2, 31) - 1);

// update frozen variables
if array_length(WC_frozenvar) != 0
{
	for (i = 0; i < array_length(WC_frozenvar); i++)
	{
		if WC_frozenvar[i] != undefined
		{
			if string_copy(WC_frozenvar[i], 1, 13) == "__WC_GLOBAL__"
				variable_global_set(string_replace(WC_frozenvar[i], "__WC_GLOBAL__", ""), WC_frozenval[i]);
			else if instance_exists(WC_frozenobj[i])
				variable_instance_set(WC_frozenobj[i], WC_frozenvar[i], WC_frozenval[i]);
		}
	}
}

// when you drag
if WC_candrag && WC_assetfinder < 0 && !WC_creatingobj && WC_selectobj == 0
{
	// stop dragging
	if mouse_check_button_released(mb_left)
	or (mouse_check_button_released(mb_middle) && !mouse_check_button(mb_left))
	{
		WC_dragobj = noone;
	
		if instance_exists(WC_fakedragobj)
		{
			with WC_fakedragobj
			{
				x = floor((mouse_x - other.WC_moffsetx) / other.WC_draggrid) * other.WC_draggrid;
				y = floor((mouse_y - other.WC_moffsety) / other.WC_draggrid) * other.WC_draggrid;
				
				if object_index == obj_otherplayer // pt online exclusive
					gms_p2p_send(p2p.wcdrag, player_id, x, y);
			}
			
			// just incase the object's coordinates are frozen
			for (i = 0; i < array_length(WC_frozenobj); i++)
			{
				if WC_fakedragobj == WC_frozenobj[i]
				{
					if WC_frozenvar[i] == "x"
						WC_frozenval[i] = WC_fakedragobj.x;
					if WC_frozenvar[i] == "y"
						WC_frozenval[i] = WC_fakedragobj.y;
				}
			}
			
			WC_fakedragobj = noone;
		}
	}

	// object gone failsafe
	if !instance_exists(WC_dragobj)
		WC_dragobj = noone;
	if !instance_exists(WC_fakedragobj)
		WC_fakedragobj = noone;

	// actually drag the object
	if instance_exists(WC_dragobj)
	{
		with WC_dragobj
		{
			x = floor((mouse_x - other.WC_moffsetx) / other.WC_draggrid) * other.WC_draggrid;
			y = floor((mouse_y - other.WC_moffsety) / other.WC_draggrid) * other.WC_draggrid;
			
			if object_index == obj_otherplayer // pt online exclusive
				gms_p2p_send(p2p.wcdrag, player_id, x, y);
		}
		
		// just incase the object's coordinates are frozen
		for (i = 0; i < array_length_1d(WC_frozenobj); i++)
		{
			if WC_dragobj == WC_frozenobj[i]
			{
				if WC_frozenvar[i] == "x"
					WC_frozenval[i] = WC_dragobj.x;
				if WC_frozenvar[i] == "y"
					WC_frozenval[i] = WC_dragobj.y;
			}
		}
	
		if mouse_check_button_pressed(mb_right)
			instance_destroy(WC_dragobj);
	}

	// start dragging the object
	if mouse_check_button_pressed(mb_left) && !(WC_consoleopen && WC_my <= WC_maxconsolebottom)
	{
		if keyboard_check(vk_control) && instance_exists(obj_player) // drag player
		{
			WC_moffsetx = 0;
			WC_moffsety = 0;
		
			if keyboard_check(vk_alt)
				WC_fakedragobj = instance_find(obj_player, 0);
			else
				WC_dragobj = instance_find(obj_player, 0);
		}
		else if keyboard_check(vk_alt) // fake drag
		{
			WC_fakedragobj = collision_point(mouse_x, mouse_y, all, true, false);
			if instance_exists(WC_fakedragobj)
			{
				// pt exclusive
				if WC_fakedragobj.object_index == obj_baddiecollisionbox
				&& WC_prioritizebaddies
				{
					if instance_exists(WC_fakedragobj.baddieID)
						WC_fakedragobj = WC_fakedragobj.baddieID;
				}
				WC_moffsetx = mouse_x - WC_fakedragobj.x;
				WC_moffsety = mouse_y - WC_fakedragobj.y;
			}
		}
		else // normal drag
		{
			WC_dragobj = collision_point(mouse_x, mouse_y, all, true, false);
			if instance_exists(WC_dragobj)
			{
				// pt exclusive
				if WC_dragobj.object_index == obj_baddiecollisionbox
				&& WC_prioritizebaddies
				{
					if instance_exists(WC_dragobj.baddieID)
						WC_dragobj = WC_dragobj.baddieID;
				}
				WC_moffsetx = mouse_x - WC_dragobj.x;
				WC_moffsety = mouse_y - WC_dragobj.y;
			}
		}
	}

	// cancel fakedrag
	if mouse_check_button_pressed(mb_right) && instance_exists(WC_fakedragobj)
		WC_fakedragobj = noone;

	// duplicate the object
	if mouse_check_button_pressed(mb_middle) && !(WC_consoleopen && WC_my <= WC_maxconsolebottom)
	{
		if !instance_exists(WC_fakedragobj)
		{
			if !instance_exists(WC_dragobj)
				WC_dragobj = collision_point(mouse_x, mouse_y, all, false, false);
	
			if instance_exists(WC_dragobj)
			{
				with WC_dragobj
				{
					if other.WC_prioritizebaddies && object_index == obj_baddiecollisionbox // pt exclusive
					{
						var copy = noone;
						with baddieID
							copy = instance_copy(false);
						other.WC_dragobj = copy;
					}
					else
						other.WC_dragobj = instance_copy(false);
				}
				if !mouse_check_button(mb_left)
				{
					WC_moffsetx = mouse_x - WC_dragobj.x;
					WC_moffsety = mouse_y - WC_dragobj.y;
				}
				
				// pt exclusive
				if WC_prioritizebaddies
					with WC_dragobj
						boundbox = false;
			}
		}
		else
		{
			with WC_fakedragobj
			{
				var copyobj = instance_copy(false);
				copyobj.x = round(mouse_x - other.WC_moffsetx);
				copyobj.y = round(mouse_y - other.WC_moffsety);
			}
		}
	}

	// mass duplicate the object
	if keyboard_check(vk_control) && mouse_check_button(mb_middle) && instance_exists(WC_dragobj)
	{
		with WC_dragobj
			instance_copy(false);
	}
	if keyboard_check(vk_control) && mouse_check_button(mb_middle) && instance_exists(WC_fakedragobj)
	{
		with WC_fakedragobj
		{
			var copyobj = instance_copy(false);
			copyobj.x = round(mouse_x - other.WC_moffsetx);
			copyobj.y = round(mouse_y - other.WC_moffsety);
		}
	}
	
	// mass delete objects
	if mouse_check_button(mb_right) && keyboard_check(vk_control)
	{
		var delobj = collision_point(mouse_x, mouse_y, all, false, false);
		if instance_exists(delobj)
			instance_destroy(delobj);
	}
}
else
{
	WC_dragobj = noone;
	WC_fakedragobj = noone;
}

// clicking to create objects
if WC_creatingobj
{
	WC_consoleopen = false;
	WC_dragobj = noone;
	WC_fakedragobj = noone;
	
	if mouse_check_button_pressed(mb_left) or (mouse_check_button(mb_left) && keyboard_check(vk_control))
		instance_create(floor(mouse_x / WC_draggrid) * WC_draggrid, floor(mouse_y / WC_draggrid) * WC_draggrid, WC_tempobj);
	
	if mouse_check_button_pressed(mb_right)
		WC_creatingobj = false;
}

// all functions
if WC_selectobj != 0
{
	WC_creatingobj = false;
	WC_consoleopen = false;
	WC_dragobj = noone;
	WC_fakedragobj = noone;
	
	tempobj = collision_point(mouse_x, mouse_y, all, false, false);
	
	// pt exclusive
	if instance_exists(tempobj) && tempobj.object_index == obj_baddiecollisionbox
	&& WC_prioritizebaddies
	{
		if instance_exists(tempobj.baddieID)
			tempobj = tempobj.baddieID;
	}
	
	WC_tempobj = tempobj;
	var selected = false;
	
	// manual input
	if mouse_check_button_pressed(mb_middle)
	{
		var tempobj_name = get_string("Manual object selection:\nInput the object's name", "");
		if tempobj_name == ""
		{
			WC_selectobj = 0;
			WC_tempobj = noone;
			exit;
		}
		else
		{
			tempobj = asset_get_index(tempobj_name);
			
			if tempobj == -1
			{
				show_message("Object " + tempobj_name + " doesn't exist. Check for typos");
				WC_selectobj = 0;
				WC_tempobj = noone;
				exit;
			}
			else if asset_get_type(tempobj_name) != asset_object
			{
				show_message("The asset " + tempobj_name + " isn't an object");
				WC_selectobj = 0;
				WC_tempobj = noone;
				exit;
			}
			else
			{
				if instance_number(tempobj) == 1
				{
					tempobj = instance_find(tempobj, 0);
					selected = true;
				}
				else if instance_number(tempobj) == 0
				{
					show_message("The object isn't in the room.");
					WC_selectobj = 0;
					WC_tempobj = noone;
					exit;
				}
				else if instance_number(tempobj) > 1
				{
					temp_objfind = get_integer("Multiple instances of this object were found. Specify which (0 to " + string(instance_number(tempobj) - 1) + ")", 0);
					tempobj = instance_find(tempobj, temp_objfind);
					if tempobj == noone
					{
						show_message("The object isn't in the room.");
						WC_selectobj = 0;
						WC_tempobj = noone;
						exit;
					}
					selected = true;
				}
			}
		}
	}
	
	if (mouse_check_button_pressed(mb_left) or selected) && instance_exists(tempobj)
	{
		WC_tempobj = noone;
		switch WC_selectobj
		{
			case 1: // set variable
				tempvar = get_string("Selected " + object_get_name(tempobj.object_index) + "\nInput variable name here", "");
				if tempvar == ""
				{
					WC_selectobj = 0;
					exit;
				}
				if variable_instance_exists(tempobj, tempvar) && is_array(variable_instance_get(tempobj, tempvar))
					show_message("The variable " + tempvar + " is an array. Set arrays with the array command");
				
				if variable_instance_exists(tempobj, tempvar)
					tempval = get_string("Overwriting existing value from " + tempvar + " to...", string(variable_instance_get(tempobj, tempvar)));
				else
					tempval = get_string("Creating new variable " + tempvar + " with value...", "");
				
				if tempval == ""
				{
					WC_selectobj = 0;
					exit;
				}
				
				if asset_get_index(tempval) != -1 // asset
				{
					variable_instance_set(tempobj, tempvar, asset_get_index(tempval));
					show_message("Set variable " + string(tempvar) + " to asset " + tempval);
				}
				else if string_length(string_digits(tempval)) + string_count("-", tempval) + string_count(".", tempval) == string_length(tempval)
				// number
				{
					variable_instance_set(tempobj, tempvar, real(tempval));
					show_message("Set variable " + string(tempvar) + " to number " + tempval);
				}
				else if tempval == "undefined" // undefined
				{
					variable_instance_set(tempobj, tempvar, undefined);
					show_message("Set variable " + string(tempvar) + " to undefined");
				}
				else // string
				{
					tempval = string_replace(tempval, "\\", "");
					variable_instance_set(tempobj, tempvar, tempval);
					show_message("Set variable " + string(tempvar) + " to string " + tempval);
				}
				
				// set variable if frozen
				for (i = 0; i < array_length_1d(WC_frozenobj); i++)
				{
					if tempobj == WC_frozenobj[i] && tempvar == WC_frozenvar[i]
						WC_frozenval[i] = variable_instance_get(tempobj, tempvar);
				}
				break;
			
			case 2: // freeze variable
				tempvar = get_string("Selected " + object_get_name(tempobj.object_index) + "\nInput variable name to freeze here", "");
				if tempvar == ""
				{
					WC_selectobj = 0;
					exit;
				}
				
				if variable_instance_exists(tempobj, tempvar)
				{
					frz = array_length_1d(WC_frozenobj)
					for (i = 0; i < frz; i++)
					{
						// unfreeze variable
						if tempobj == WC_frozenobj[i] && tempvar == WC_frozenvar[i]
						{
							WC_frozenobj[i] = noone;
							WC_frozenvar[i] = undefined;
							WC_frozenval[i] = undefined;
							
							WC_selectobj = 0;
							show_message("UNFROZEN variable " + tempvar + " in object " + object_get_name(tempobj.object_index));
							exit;
						}
					}
					for (i = 0; i < frz; i++)
					{
						// find undefined slot to replace
						if WC_frozenvar[i] == undefined
							frz = i;
					}
					
					WC_frozenobj[frz] = tempobj;
					WC_frozenvar[frz] = tempvar;
					WC_frozenval[frz] = variable_instance_get(tempobj, tempvar);
					show_message("Frozen variable " + tempvar + " in object " + object_get_name(tempobj.object_index) + " to value of " + string(WC_frozenval[frz]));
				}
				else
					show_message("Variable " + tempvar + " doesn't exist. Check for typos");
				break;
			
			case 3: // execute script
				tempscript = get_string("Input script here", "");
				if tempscript == ""
				{
					WC_selectobj = 0;
					exit;
				}
				
				var get_script = asset_get_index(tempscript)
				if get_script == -1
				{
					show_message("Script " + tempscript + "doesn't exist");
					WC_selectobj = 0;
					exit;
				}
				if asset_get_type(tempscript) != asset_script
				{
					show_message("The asset " + tempscript + " isn't a script");
					WC_selectobj = 0;
					exit;
				}
				
				var script_argcount = get_integer("Number of arguments? (Max 10)", 0);
				i = 0;
				
				scrarg[0] = undefined;
				scrarg[1] = undefined;
				scrarg[2] = undefined;
				scrarg[3] = undefined;
				scrarg[4] = undefined;
				scrarg[5] = undefined;
				scrarg[6] = undefined;
				scrarg[7] = undefined;
				scrarg[8] = undefined;
				scrarg[9] = undefined;
				
				repeat clamp(script_argcount, 0, 10)
				{
					scrarg[i] = get_string("Type in the value for argument " + string(i), "");
					if asset_get_index(scrarg[i]) != -1 // asset
						scrarg[i] = asset_get_index(scrarg[i]);
					else if string_length(string_digits(scrarg[i])) + string_count("-", scrarg[i]) + string_count(".", scrarg[i]) == string_length(scrarg[i])
					// number
						scrarg[i] = real(scrarg[i]);
					else if scrarg[i] == "undefined" // undefined
						scrarg[i] = undefined;
					i++;
				}
				
				with tempobj
					script_execute(get_script, scrarg[0], scrarg[1], scrarg[2], scrarg[3], scrarg[4], scrarg[5], scrarg[6], scrarg[7], scrarg[8], scrarg[9])
				break;
			
			case 4: // debug
				WC_debuginfo = true;
				show_debug_overlay(WC_debuginfo);
				
				WC_debugselected = tempobj;
				WC_debugvarstart = 0;
				break;
			
			case 5: // set array
				tempvar = get_string("Selected " + object_get_name(tempobj.object_index) + "\nInput array name here", "");
				if tempvar == ""
				{
					WC_selectobj = 0;
					exit;
				}
				
				if variable_instance_exists(tempobj, tempvar) && !is_array(variable_instance_get(tempobj, tempvar))
				{
					show_message("The variable " + tempvar + " isn't an array.");
					WC_selectobj = 0;
					exit;
				}
				
				if variable_instance_exists(tempobj, tempvar)
				{
					tempind = get_integer("Input which index in the array to access", 0);
					temparray = variable_instance_get(tempobj, tempvar);
				}
				else
					tempind = get_integer("Variable " + tempvar + " doesn't exist, creating new array.\nInput which index in the array to access", 0);
				
				if tempind < 0
				{
					show_message("Negative indexes are not allowed")
					WC_selectobj = 0;
					exit;
				}
				
				if tempind < array_length_1d(temparray) && temparray[tempind] != pointer_null
					tempval = get_string("Overwriting existing value from " + tempvar + "[" + string(tempind) + "] to...", temparray[tempind]);
				else
					tempval = get_string("Creating new index for " + tempvar + "[" + string(tempind) + "] with value of...", "");
				
				if tempval == ""
				{
					WC_selectobj = 0;
					exit;
				}
				
				if asset_get_index(tempval) != -1 // asset
				{
					temparray[tempind] = asset_get_index(tempval);
					
					variable_instance_set(tempobj, tempvar, temparray);
					show_message("Set array " + string(tempvar) + "[" + string(tempind) + "] to asset " + tempval);
				}
				else if string_length(string_digits(tempval)) + string_count("-", tempval) + string_count(".", tempval) == string_length(tempval)
				// number
				{
					temparray[tempind] = real(tempval);
					
					variable_instance_set(tempobj, tempvar, temparray);
					show_message("Set array " + string(tempvar) + "[" + string(tempind) + "] to number " + tempval);
				}
				else if tempval == "undefined"
				// undefined
				{
					temparray[tempind] = undefined;
					
					variable_instance_set(tempobj, tempvar, temparray);
					show_message("Set array " + string(tempvar) + "[" + string(tempind) + "] to undefined");
				}
				else // string
				{
					temparray[tempind] = string_replace(tempval, "\\", "");
					
					variable_instance_set(tempobj, tempvar, temparray);
					show_message("Set array " + string(tempvar) + "[" + string(tempind) + "] to string " + temparray[tempind]);
				}
				break;
			
			case 6: // monitor variable
				tempvar = get_string("Selected " + object_get_name(tempobj.object_index) + "\nInput variable to monitor here", "");
				if tempvar == ""
				{
					WC_selectobj = 0;
					exit;
				}
				
				if variable_instance_exists(tempobj, tempvar)
				{
					WC_varmonitor = tempvar;
					WC_varobj = tempobj;
					show_message("Now monitoring " + object_get_name(tempobj.object_index) + "." + tempvar);
					break;
				}
				else
					show_message("The variable \"" + tempvar + "\"" + " doesn't exist. Check for typos");
				break;
		}
		
		WC_selectobj = 0;
	}
	
	// cancel
	if mouse_check_button_pressed(mb_right)
		WC_selectobj = 0;
}


// travel rooms
/*
if keyboard_check_pressed(vk_insert) && room_exists(room_next(room))
{
	with obj_player // pt exclusive
		targetDoor = "none";
	room_goto_next();
}
if keyboard_check_pressed(vk_delete) && room_exists(room_previous(room))
{
	with obj_player // pt exclusive
		targetDoor = "none";
	room_goto_previous();
}
*/


// delete if multiple instances
if instance_number(object_index) > 1
	instance_destroy(instance_find(object_index, instance_number(object_index) - 1));