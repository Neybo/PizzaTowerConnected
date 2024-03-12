/// @description scr_wcevaluate(command)
/// @param command
function scr_wcevaluate(argument0)
{
	var eval = argument0;
	var tempobj, tempvar, temparray, tempind, tempval, tempscript, temproom, temp_fetchobjects, tempsound, temp_objfind, arg0, arg1, arg2, arg3, frz, i, scrarg, __tempsomething; // funny variables

	// fetch arguments
	var arg = ds_list_create();
	var substr = "";
	var quote = false;
	
	for (i = 1; i <= string_length(eval); i++)
	{
		var next_char = string_char_at(eval, i);
	
		if next_char == "'" or next_char == "\""
			quote = !quote;
		else if next_char != " " or quote
			substr += next_char;
		else
		{
			if substr != ""
				ds_list_add(arg, substr);
			substr = "";
		}
	
		if i == string_length(eval) && substr != ""
			ds_list_add(arg, substr);
	}
	
	// argument variables
	arg0 = string(ds_list_find_value(arg, 0));
	arg1 = ds_list_find_value(arg, 1);
	var commandargs = string_replace(eval, arg0 + " ", "");
	
	// execute the commands
	switch arg0
	{
		case "rpc":
			with obj_drpc_updater
			{
				event_user(1)
				event_user(0)
				event_user(3)
				event_perform(ev_other, 4)
			}
			break;
		case "whoami":
			WC_consoleopen = true;
			console_log("PID " + string(gms_self_playerid()) 
			+ " - Name \"" + string(gms_self_name())
			+ "\" - In session " + string(gms_session_current_id()));
			break;
		// useless
		case "sv_cheats":
			arg1 = ds_list_find_value(arg, 1);
			if arg1 == "1"
			{
				WC_consoleopen = true;
				console_log("thats not funny");
			}
			else if arg1 == "0"
				instance_destroy();
			else
			{
				WC_consoleopen = true;
				console_log(arg1 + " is not a valid bool");
			}
			break;
			
		case "noclip":
			window_mouse_set(obj_player.x - _camx, obj_player.y - _camy + 10);
			console_log("Tip: Click an object to drag it!");
			break;
			
		case "help":
		case "?":
			WC_consoleopen = true;
			console_log("Command help cannot be found.");
			break;
	
		case "impulse": // pt exclusive
			arg1 = ds_list_find_value(arg, 1);
			if arg1 == "101" && instance_exists(obj_player)
			{
				obj_player.shotgunAnim = !obj_player.shotgunAnim;
				global.gotshotgun = !global.gotshotgun;
				scr_soundeffect(sfx_shotgungot);
			}
			else
			{
				WC_consoleopen = true;
				console_log("Invalid command " + arg0);
			}
			break;
			
		// console settings
		case "consolesize":
		case "consoleresize":
		case "resizeconsole":
			arg1 = ds_list_find_value(arg, 1);
			if is_undefined(arg1)
			{
				WC_consoleopen = true;
				console_log(lang_str("online.usage") + ": consolesize SIZE");
			}
			else if string_digits(arg1) == arg1 // index
			{
				WC_consoleopen = true;
				WC_maxconsolebottom = clamp(real(arg1), 20, 540);
			}
			else
			{
				WC_consoleopen = true;
				console_log("Size parameter must be a whole number");
			}
			break;
			
		case "consolecolor":
		case "consolecol":
		case "color":
			arg1 = ds_list_find_value(arg, 1);
			arg2 = ds_list_find_value(arg, 2);
			arg3 = ds_list_find_value(arg, 3);
				
			if is_undefined(arg1) or is_undefined(arg2) or is_undefined(arg3)
			{
				console_log(lang_str("online.usage") + ": consolecolor R G B");
				WC_consoleopen = true;
			}
			else
			{
				if string_length(string_digits(arg1)) + string_count("-", arg1) + string_count(".", arg1) == string_length(arg1)
				&& string_length(string_digits(arg2)) + string_count("-", arg2) + string_count(".", arg2) == string_length(arg2)
				&& string_length(string_digits(arg3)) + string_count("-", arg3) + string_count(".", arg3) == string_length(arg3)
				{
					arg1 = clamp(real(arg1), 0, 255);
					arg2 = clamp(real(arg2), 0, 255);
					arg3 = clamp(real(arg3), 0, 255);
						
					WC_consolecolor = make_colour_rgb(arg1, arg2, arg3);
					WC_consoleopen = true;
				}
				else
				{
					console_log("Parameters must be numbers");
					WC_consoleopen = true;
				}
			}
			break;
	
		case "prioritizebaddies": // pt exclusive
		case "dragbaddies":
			WC_prioritizebaddies = !WC_prioritizebaddies;
			if WC_consoleopen
			{
				if WC_prioritizebaddies
					console_log("Now prioritizing baddies over their collision when dragging");
				else
					console_log("Prioritize baddies OFF");
			}
			else
			{
				with obj_tv
				{
					showtext = true;
					alarm[0] = 100;
					if other.WC_prioritizebaddies
						message = "PRIORITIZE BADDIES ON";
					else
						message = "PRIORITIZE BADDIES OFF";
				}
			}
			break;
			
		case "drag":
		case "toggledrag":
			WC_dragobj = noone;
			WC_fakedragobj = noone;
			WC_candrag = !WC_candrag;
		
			if WC_consoleopen
			{
				if WC_candrag
					console_log("Dragging ON");
				else
					console_log("Dragging OFF");
			}
			else
			{
				with obj_tv
				{
					showtext = true;
					alarm[0] = 100;
					if other.WC_candrag
						message = "DRAGGING ON";
					else
						message = "DRAGGING OFF";
				}
			}
			break;
	
		case "grid":
		case "gridsize":
			if !is_undefined(arg1) && string_digits(arg1) == arg1
			{
				__tempsomething = real(arg1);
				if __tempsomething <= 0
				{
					WC_consoleopen = true;
					console_log("Parameter must be greater than 0");
				}
				else
				{
					WC_draggrid = __tempsomething;
					console_log("Set grid to " + string(__tempsomething));
				}
			}
			else if is_undefined(arg1)
			{
				if WC_consoleopen
				{
					if WC_draggrid != 1
					{
						WC_draggrid = 1;
						console_log("Disabled grid");
					}
					else
						console_log(lang_str("online.usage") + ": grid SIZE");
				}
				else
				{
					__tempsomething = get_integer("Input grid size", WC_draggrid);
					if __tempsomething != WC_draggrid
					{
						if __tempsomething <= 0
							show_message("Parameter must be greater than 0");
						else
						{
							WC_draggrid = __tempsomething;
							show_message("Set grid to " + string(__tempsomething));
						}
					}
				}
			}
			else
			{
				WC_consoleopen = true;
				console_log("Parameter must be a number");
			}
		
			if WC_draggrid == 0
				WC_draggrid = 1;
			break;
			
		case "clear":
		case "clean":
		case "cls":
			ds_list_clear(WC_consolelist);
			break;
			
		// actual commands
		case "endgame":
			fmod_destroy();
			game_end();
			break;
		
		case "restartgame":
			fmod_destroy();
			game_restart();
			break;

				
		case "echo":
			if string_char_at(ds_list_find_value(WC_consolelist, 0), 1) == "%"
				ds_list_delete(WC_consolelist, 0);
		
			if !WC_consoleopen // pt exclusive
			{
				with obj_tv
				{
					message = string_upper(commandargs);
					showtext = true;
					alarm[0] = 100;
				}
			}
			else
			{
				if string_char_at(commandargs, 1) == "%"
					commandargs = string_replace(commandargs, "%", "");
				console_log(commandargs);
			}
			break;
			
		case "sleep": // pt exclusive
			arg1 = ds_list_find_value(arg, 1);
				
			if is_undefined(arg1)
			{
				if WC_consoleopen
					console_log(lang_str("online.usage") + ": sleep MILISECONDS");
				else
				{
					__tempsomething = get_integer("Input miliseconds to sleep", 0);
					if __tempsomething > 0
						scr_sleep(__tempsomething);
				}
			}
			else if string_length(string_digits(arg1)) + string_count("-", arg1) + string_count(".", arg1) == string_length(arg1)
				scr_sleep(real(arg1));
			else
			{
				console_log("Parameter must be a number");
				WC_consoleopen = true;
			}
			break;
		
		case "repeat":
			arg1 = ds_list_find_value(arg, 1);
			if !is_undefined(arg1) && !is_undefined(ds_list_find_value(arg, 2))
			{
				if string_length(string_digits(arg1)) + string_count("-", arg1) + string_count(".", arg1) == string_length(arg1)
				{
					if real(arg1) <= 0
					{
						WC_consoleopen = true;
						console_log("Times parameter must be greater than zero");
					}
					else
					{
						repeat real(arg1)
							scr_wcevaluate(string_replace(commandargs, arg1 + " ", ""));
					}
				}
			}
			else
			{
				WC_consoleopen = true;
				console_log(lang_str("online.usage") + ": repeat TIMES COMMAND");
			}
			break;
			
		case "playsound":
		case "sound":
		case "audio":
			arg1 = ds_list_find_value(arg, 1);
			arg2 = ds_list_find_value(arg, 2);
		
			if !is_undefined(arg2)
				arg2 = string_lower(arg2);
			else 
				arg2 = false
				
			if is_undefined(arg1)
			{
				console_log(lang_str("online.usage") + ": playsound SOUND LOOP"); // pt exclusive
				WC_consoleopen = true;
			}
			else
			{
				tempsound = arg1;
				if fmod_event_instance_exists(tempsound)
				{
					if (ds_list_find_value(args, 0) != -1)
					{
						var ___snd = scr_sound(tempsound, false);
					}
					with obj_music
					{
						adminmus = ___snd;
					}
				}
				else
				{
					console_log("Sound doesn't exist");
					WC_consoleopen = true;
				}
			}
			break;
			
		case "room":
		case "goto":
		case "room_goto":
		case "rm":
			arg1 = ds_list_find_value(arg, 1);
			arg2 = ds_list_find_value(arg, 2);
			
			if is_undefined(arg1)
			{
				console_log("Current room: " + string(room) + " " + room_get_name(room));
			}
			else if string_length(string_digits(arg1)) + string_count("-", arg1) + string_count(".", arg1) == string_length(arg1)
			{
				if room_exists(real(arg1))
				{
					if is_fullgame_room(real(arg1)) and !fullgame
						console_log("You can't go there! Buy Pizza Tower first!");
					else
					{
						console_log("Successfully traveled to " + room_get_name(real(arg1)) 
						+ " with index: " + arg1);
						room_goto(real(arg1));
					
						// pt exclusive
						if is_undefined(arg2) with obj_player
							targetDoor = "none";
						else with obj_player
							targetDoor = arg2;
					}
				}
				else
				{
					WC_consoleopen = true;
					console_log("Room index out of range");
				}
			}
			else
			{
				temproom = asset_get_index(arg1);
			
				if temproom == -1
				{
					WC_consoleopen = true;
					console_log("The room " + arg1 + " doesn't exist. Check for typos");
				}
				else if asset_get_type(arg1) != asset_room
				{
					WC_consoleopen = true;
					console_log("The asset " + arg1 + " isn't a room");
				}
				else
				{
					console_log("Successfully traveled to " + arg1 + " with index: " + string(temproom));
					room_goto(temproom);
						
					// pt exclusive
					if is_undefined(arg2) with obj_player
						targetDoor = "none";
					else with obj_player
						targetDoor = arg2;
				}
			}
			break;
			
		case "reset":
		case "restart":
		case "roomrestart":
			room_restart();
			console_log("Restarted the current room (" + string(room_get_name(room)) + ")");
			break;
			
		case "fps":
		case "speed":
		case "roomspeed":
			arg1 = ds_list_find_value(arg, 1);
				
			if is_undefined(arg1)
			{
				if !WC_consoleopen // binded command
				{
					tempval = get_string("Input room speed", string(room_speed));
					
					if tempval == "" or tempval == undefined
					{
						// do literally nothing dumbass
					}
					else if string_length(string_digits(tempval)) + string_count("-", tempval) + string_count(".", tempval) == string_length(tempval)
					{
						if real(tempval) < 1
							show_message("Room speed must be greater than zero");
						else
						{
							room_speed = real(tempval);
							show_message("Set room speed to " + tempval);
						}
					}
					else
						show_message("Value must be a number");
				}
				else
					console_log(lang_str("online.usage") + ": speed NUMBER");
			}
			else
			{
				if string_length(string_digits(arg1)) + string_count("-", arg1) + string_count(".", arg1) == string_length(arg1)
				{
					if real(arg1) < 1
					{
						WC_consoleopen = true;
						console_log("Room speed must be greater than zero");
					}
					else
					{
						room_speed = real(arg1);
						console_log("Set room speed to " + arg1);
					}
				}
				else
				{
					WC_consoleopen = true;
					console_log("Value must be a number");
				}
			}
			break;
		
		case "obj":
		case "object":
		case "create":
		case "instancecreate":
			arg1 = ds_list_find_value(arg, 1);
			if is_undefined(arg1)
			{
				console_log(lang_str("online.usage") + ": object OBJECT X Y");
			}
			else
			{
				var __isindex = false;
				if string_length(string_digits(arg1)) + string_count("-", arg1) + string_count(".", arg1) == string_length(arg1)
				{
					WC_tempobj = real(arg1);
					__isindex = true;
				}
				else
					WC_tempobj = asset_get_index(arg1);
				
				if WC_tempobj == -1 or !object_exists(WC_tempobj)
				{
					console_log("Asset " + arg1 + " doesn't exist. Check for typos");
					WC_consoleopen = true;
				}
				else if asset_get_type(arg1) != asset_object && !__isindex
				{
					console_log("The asset " + arg1 + " isn't an object");
					WC_consoleopen = true;
				}
				else
				{
					arg2 = ds_list_find_value(arg, 2);
					arg3 = ds_list_find_value(arg, 3);
					
					if is_undefined(arg2)
					{
						WC_consoleopen = false;
						WC_creatingobj = true;
					}
					else if is_undefined(arg3)
					{
						WC_consoleopen = true;
						console_log(lang_str("online.usage") + ": object OBJECT X Y");
					}
					else if string_length(string_digits(arg2)) + string_count("-", arg2) + string_count(".", arg2) == string_length(arg2)
					{
						if string_length(string_digits(arg3)) + string_count("-", arg3) + string_count(".", arg3) == string_length(arg3)
						{
							var __objname = object_get_name(instance_create(real(arg2), real(arg3), WC_tempobj).object_index);
							console_log("Successfully created object " + __objname + " at x" + arg2 + " y" + arg3);
						}
						else
						{
							WC_consoleopen = true;
							console_log("Y parameter must be a number");
						}
					}
					else
					{
						WC_consoleopen = true;
						console_log("X parameter must be a number");
					}
				}
			}
			break;
	
		case "listobjects":
		case "objectlist":
		case "instancelist":
			temp_fetchobjects = "There are " + string(instance_count) + " instances in this room: ";
			with all
				temp_fetchobjects += object_get_name(object_index) + ", ";
				
			if !WC_consoleopen
				show_message(string_replace_all(string_replace_all(temp_fetchobjects, ", ", "\n"), "room: ", "room:\n"));
			else
				console_log(temp_fetchobjects);
			break
		
		case "playerstate":
		case "state":
		case "setstate": // pt exclusive
			if instance_exists(obj_player)
			{
				arg1 = ds_list_find_value(arg, 1);
				if is_undefined(arg1)
				{
					if !WC_consoleopen
					{
						__tempsomething = get_integer("Input player state", obj_player.state);
						if __tempsomething != undefined
						{
							with obj_player
								state = __tempsomething;
						}
					}
					else
						console_log(lang_str("online.usage") + ": state NUMBER");
				}
				else if string_length(string_digits(arg1)) + string_count("-", arg1) + string_count(".", arg1) == string_length(arg1)
				{
					obj_player.state = real(arg1);
					console_log("Set player 1 state to " + arg1);
				}
				else
				{
					WC_consoleopen = true;
					console_log("State parameter must be a number");
				}
			}
			else
			{
				WC_consoleopen = true;
				console_log("Player object doesn't exist");
			}
			break;
		
		case "oobcam":
		case "oobcamera": // pt exclusive
			WC_oobcam = !WC_oobcam;
			if !WC_consoleopen
			{
				with obj_tv
				{
					showtext = true;
					alarm[0] = 100;
					if other.WC_oobcam
						message = "LIMITLESS CAMERA ON";
					else
						message = "LIMITLESS CAMERA OFF";
				}
			}
			else
			{
				if WC_oobcam
					console_log("Limitless camera ON");
				else
					console_log("Limitless camera OFF");
			}
			break;
			
		case "variable":
		case "var":
		case "setvar":
			tempobj = ds_list_find_value(arg, 1);
			tempvar = ds_list_find_value(arg, 2);
			tempval = ds_list_find_value(arg, 3);
			
			var setmsg = "Set ";
			if is_undefined(tempobj)
			{
				console_log(lang_str("online.usage") + ": variable global VARIABLE VALUE or variable OBJECT FIND VARIABLE VALUE");
			}
			else
			{
				if is_undefined(tempvar) or is_undefined(tempval)
				{
					console_log(lang_str("online.usage") + ": variable global VARIABLE VALUE or variable OBJECT FIND VARIABLE VALUE");
					WC_consoleopen = true;
				}
				else if tempobj == "global" // global
				{
					tempvar = string_replace(tempvar, "global.", "");
					tempval = string_replace(commandargs, tempobj + " ", "");
					tempval = string_replace(tempval, tempvar + " ", "");
				
					if variable_global_exists(tempvar)
					&& is_array(variable_global_get(tempvar))
					{
						console_log("The global variable " + tempvar + " is an array. Set arrays with the array command");
						WC_consoleopen = true;
					}
					else
					{
						if !variable_global_exists(tempvar)
							setmsg = "Created ";
				
						if asset_get_index(tempval) != -1 // asset
						{
							variable_global_set(tempvar, asset_get_index(tempval));
							console_log(setmsg + "global variable global." + string(tempvar) + " to asset " + tempval);
						}
						else if string_length(string_digits(tempval)) + string_count("-", tempval) + string_count(".", tempval) == string_length(tempval)
						// number
						{
							variable_global_set(tempvar, real(tempval));
							console_log(setmsg + "global variable global." + string(tempvar) + " to number " + tempval);
						}
						else if tempval == "undefined" // undefined
						{
							variable_global_set(tempvar, undefined);
							console_log(setmsg + "global variable global." + string(tempvar) + " to undefined");
						}
						else // string
						{
							tempval = string_replace(tempval, "\\", "");
							variable_global_set(tempvar, tempval);
							console_log(setmsg + "global variable global." + string(tempvar) + " to string " + tempval);
						}
				
						// set variable if frozen
						for (i = 0; i < array_length(WC_frozenobj); i++)
						{
							if "__WC_GLOBAL__" + tempvar == WC_frozenvar[i]
								WC_frozenval[i] = variable_global_get(tempvar);
						}
					}
				}
				else
				{
					temp_objfind = ds_list_find_value(arg, 2);
						
					if string_length(string_digits(temp_objfind)) + string_count("-", temp_objfind) + string_count(".", temp_objfind) != string_length(temp_objfind)
					&& string_lower(temp_objfind) != "all"
					{
						console_log("FIND parameter must be a number");
						WC_consoleopen = true;
					}
					else if is_undefined(temp_objfind)
					{
						console_log(lang_str("online.usage") + ": variable OBJECT FIND VARIABLE VALUE");
						WC_consoleopen = true;
					}
					else
					{
						tempvar = ds_list_find_value(arg, 3);
						tempval = ds_list_find_value(arg, 4);
					
						if is_undefined(tempval)
						{
							console_log(lang_str("online.usage") + ": variable OBJECT FIND VARIABLE VALUE");
							WC_consoleopen = true;
						}
						else
						{
							tempval = string_replace(commandargs, tempobj + " ", "");
							tempval = string_replace(tempval, temp_objfind + " ", "");
							tempval = string_replace(tempval, tempvar + " ", "");
						
							if string_lower(temp_objfind) == "all"
								temp_objfind = all;
						
							__tempsomething = asset_get_index(tempobj);
							if __tempsomething == -1
							{
								console_log("Asset " + tempobj + " doesn't exist. Check for typos");
								WC_consoleopen = true;
							}
							else if asset_get_type(tempobj) != asset_object
							{
								console_log("The asset " + tempobj + " isn't an object");
								WC_consoleopen = true;
							}
							else
							{
								if temp_objfind != all
									__tempsomething = instance_find(__tempsomething, real(temp_objfind));
							
								if !instance_exists(__tempsomething)
								{
									console_log("Instance " + tempobj + " doesn't exist in room");
									WC_consoleopen = true;
								}
								else if variable_instance_exists(__tempsomething, tempvar) && is_array(variable_instance_get(__tempsomething, tempvar))
								&& temp_objfind != all
								{
									console_log("The variable " + tempvar + " is an array. Set arrays with the array command");
									WC_consoleopen = true;
								}
								else
								{
									if temp_objfind == all
									{
										with __tempsomething
										{
											if !variable_instance_exists(self, tempvar)
												setmsg = "Created ";
										
											if asset_get_index(tempval) != -1 // asset
											{
												variable_instance_set(self, tempvar, asset_get_index(tempval))
												ds_list_insert(other.WC_consolelist, 0, setmsg + "variable " + string(tempvar) + " to asset " + tempval + " in " + tempobj);
											}
											else if string_length(string_digits(tempval)) + string_count("-", tempval) + string_count(".", tempval) == string_length(tempval)
											// number
											{
												variable_instance_set(self, tempvar, real(tempval));	
												ds_list_insert(other.WC_consolelist, 0, setmsg + "variable " + string(tempvar) + " to number " + tempval + " in " + tempobj);
											}
											else if tempval == "undefined" // undefined
											{
												variable_instance_set(self, tempvar, undefined);
												ds_list_insert(other.WC_consolelist, 0, setmsg + "variable " + string(tempvar) + " to undefined");
											}
											else // string
											{
												tempval = string_replace(tempval, "\\", "");
												variable_instance_set(self, tempvar, tempval);
												ds_list_insert(other.WC_consolelist, 0, setmsg + "variable " + string(tempvar) + " to string " + tempval + " in " + tempobj);
											}
							
											// set variable if frozen
											for (i = 0; i < array_length(other.WC_frozenobj); i++)
											{
												if self == other.WC_frozenobj[i] && tempvar == other.WC_frozenvar[i]
													other.WC_frozenval[i] = variable_instance_get(self, tempvar);
											}
										}
									}
									else
									{
										if !variable_instance_exists(__tempsomething, tempvar)
											setmsg = "Created ";
								
										if asset_get_index(tempval) != -1 // asset
										{
											variable_instance_set(__tempsomething, tempvar, asset_get_index(tempval))
											console_log(setmsg + "variable " + string(tempvar) + " to asset " + tempval + " in " + tempobj);
										}
										else if string_length(string_digits(tempval)) + string_count("-", tempval) + string_count(".", tempval) == string_length(tempval)
										// number
										{
											variable_instance_set(__tempsomething, tempvar, real(tempval));	
											console_log(setmsg + "variable " + string(tempvar) + " to number " + tempval + " in " + tempobj);
										}
										else if tempval == "undefined" // undefined
										{
											variable_instance_set(__tempsomething, tempvar, undefined);
											console_log(setmsg + "variable " + string(tempvar) + " to undefined");
										}
										else // string
										{
											tempval = string_replace(tempval, "\\", "");
											variable_instance_set(__tempsomething, tempvar, tempval);
											console_log(setmsg + "variable " + string(tempvar) + " to string " + tempval + " in " + tempobj);
										}
							
										// set variable if frozen
										for (i = 0; i < array_length(WC_frozenobj); i++)
										{
											if __tempsomething == WC_frozenobj[i] && tempvar == WC_frozenvar[i]
												WC_frozenval[i] = variable_instance_get(__tempsomething, tempvar);
										}
									}
								}
							}
						}
					}
				}
			}
			break;
	
		case "array":
		case "setarray":
			tempobj = ds_list_find_value(arg, 1);
			tempvar = ds_list_find_value(arg, 2);
			tempind = ds_list_find_value(arg, 3);
			tempval = ds_list_find_value(arg, 4);
			
			var setmsg = "Set ";
			if is_undefined(tempobj)
			{
				console_log(lang_str("online.usage") + ": array global VARIABLE INDEX VALUE or variable OBJECT FIND VARIABLE INDEX VALUE");
			}
			else
			{
				if is_undefined(tempvar) or is_undefined(tempval) or is_undefined(tempind)
				{
					console_log(lang_str("online.usage") + ": array global VARIABLE INDEX VALUE or variable OBJECT FIND VARIABLE INDEX VALUE");
					WC_consoleopen = true;
				}
				else if tempobj == "global" // global
				{
					if string_digits(tempind) != tempind
					{
						console_log("Index parameter must be a number");
						WC_consoleopen = true;
					}
					else
					{
						tempvar = string_replace(tempvar, "global.", "");
						tempval = string_replace(commandargs, tempobj + " ", "");
						tempval = string_replace(tempval, tempvar + " ", "");
						tempval = string_replace(tempval, tempind + " ", "");
						tempind = real(tempind);
						
						if variable_global_exists(tempvar)
						&& !is_array(variable_global_get(tempvar))
						{
							console_log("The global variable " + tempvar + " is not an array.");
							WC_consoleopen = true;
						}
						else
						{
							if !variable_global_exists(tempvar)
								setmsg = "Created ";
							else
								temparray = variable_global_get(tempvar);
						
							if asset_get_index(tempval) != -1 // asset
							{
								temparray[tempind] = asset_get_index(tempval);
							
								variable_global_set(tempvar, temparray);
								console_log(setmsg + "global array global." + string(tempvar) + "[" + string(tempind) + "] to asset " + tempval);
							}
							else if string_length(string_digits(tempval)) + string_count("-", tempval) + string_count(".", tempval) == string_length(tempval)
							// number
							{
								temparray[tempind] = real(tempval);
							
								variable_global_set(tempvar, temparray);
								console_log(setmsg + "global array global." + string(tempvar) + "[" + string(tempind) + "] to number " + tempval);
							}
							else if tempval == "undefined" // undefined
							{
								temparray[tempind] = undefined;
							
								variable_global_set(tempvar, temparray);
								console_log(setmsg + "global array global." + string(tempvar) + "[" + string(tempind) + "] to undefined");
							}
							else // string
							{
								temparray[tempind] = string_replace(tempval, "\\", "");
							
								variable_global_set(tempvar, temparray);
								console_log(setmsg + "global array global." + string(tempvar) + "[" + string(tempind) + "] to string " + temparray[tempind]);
							}
				
							// set variable if frozen
							for (i = 0; i < array_length(WC_frozenobj); i++)
							{
								if "__WC_GLOBAL__" + tempvar == WC_frozenvar[i]
									WC_frozenval[i] = variable_global_get(tempvar);
							}
						}
					}
				}
				else
				{
					temp_objfind = ds_list_find_value(arg, 2);
						
					if string_length(string_digits(temp_objfind)) + string_count("-", temp_objfind) + string_count(".", temp_objfind) != string_length(temp_objfind)
					&& string_lower(temp_objfind) != "all"
					{
						console_log("FIND parameter must be a number");
						WC_consoleopen = true;
					}
					else if is_undefined(temp_objfind)
					{
						console_log(lang_str("online.usage") + ": array OBJECT FIND VARIABLE INDEX VALUE");
						WC_consoleopen = true;
					}
					else
					{
						tempvar = ds_list_find_value(arg, 3);
						tempind = ds_list_find_value(arg, 4);
						tempval = ds_list_find_value(arg, 5);
						
						if is_undefined(tempval)
						{
							console_log(lang_str("online.usage") + ": array OBJECT FIND VARIABLE INDEX VALUE");
							WC_consoleopen = true;
						}
						else if string_digits(tempind) != tempind
						{
							console_log("Index parameter must be a number");
							WC_consoleopen = true;
						}
						else
						{
							tempval = string_replace(commandargs, tempobj + " ", "");
							tempval = string_replace(tempval, temp_objfind + " ", "");
							tempval = string_replace(tempval, tempvar + " ", "");
							tempval = string_replace(tempval, tempind + " ", "");
							tempind = real(tempind);
						
							if string_lower(temp_objfind) == "all"
								temp_objfind = all;
						
							__tempsomething = asset_get_index(tempobj);
							if __tempsomething == -1
							{
								console_log("Asset " + tempobj + " doesn't exist. Check for typos");
								WC_consoleopen = true;
							}
							else if asset_get_type(tempobj) != asset_object
							{
								console_log("The asset " + tempobj + " isn't an object");
								WC_consoleopen = true;
							}
							else
							{
								if temp_objfind != all
									__tempsomething = instance_find(__tempsomething, real(temp_objfind));
							
								if !instance_exists(__tempsomething)
								{
									console_log("Instance " + tempobj + " doesn't exist in room");
									WC_consoleopen = true;
								}
								else if variable_instance_exists(__tempsomething, tempvar) && !is_array(variable_instance_get(__tempsomething, tempvar))
								&& temp_objfind != all
								{
									console_log("The variable " + tempvar + " is not an array.");
									WC_consoleopen = true;
								}
								else
								{
									if temp_objfind == all
									{
										with __tempsomething
										{
											if !variable_instance_exists(self, tempvar)
												setmsg = "Created ";
											else
												temparray = variable_instance_get(self, tempvar);
											
											if asset_get_index(tempval) != -1 // asset
											{
												temparray[tempind] = asset_get_index(tempval);
												
												variable_instance_set(self, tempvar, temparray);
												ds_list_insert(other.WC_consolelist, 0, setmsg + "array " + string(tempvar) + " to asset " + tempval + " in " + tempobj);
											}
											else if string_length(string_digits(tempval)) + string_count("-", tempval) + string_count(".", tempval) == string_length(tempval)
											// number
											{
												temparray[tempind] = real(tempval);
												
												variable_instance_set(self, tempvar, temparray);	
												ds_list_insert(other.WC_consolelist, 0, setmsg + "array " + string(tempvar) + " to number " + tempval + " in " + tempobj);
											}
											else if tempval == "undefined" // undefined
											{
												temparray[tempind] = undefined;
												
												variable_instance_set(self, tempvar, temparray);
												ds_list_insert(other.WC_consolelist, 0, setmsg + "array " + string(tempvar) + " to undefined");
											}
											else // string
											{
												temparray[tempind] = string_replace(tempval, "\\", "");
												
												variable_instance_set(self, tempvar, temparray);
												ds_list_insert(other.WC_consolelist, 0, setmsg + "array " + string(tempvar) + " to string " + temparray[tempind] + " in " + tempobj);
											}
							
											// set variable if frozen
											for (i = 0; i < array_length(other.WC_frozenobj); i++)
											{
												if self == other.WC_frozenobj[i] && tempvar == other.WC_frozenvar[i]
													other.WC_frozenval[i] = variable_instance_get(self, tempvar);
											}
										}
									}
									else
									{
										if !variable_instance_exists(__tempsomething, tempvar)
											setmsg = "Created ";
										else
											temparray = variable_instance_get(__tempsomething, tempvar);
											
										if asset_get_index(tempval) != -1 // asset
										{
											temparray[tempind] = asset_get_index(tempval);
												
											variable_instance_set(__tempsomething, tempvar, temparray);
											ds_list_insert(other.WC_consolelist, 0, setmsg + "array " + string(tempvar) + " to asset " + tempval + " in " + tempobj);
										}
										else if string_length(string_digits(tempval)) + string_count("-", tempval) + string_count(".", tempval) == string_length(tempval)
										// number
										{
											temparray[tempind] = real(tempval);
												
											variable_instance_set(__tempsomething, tempvar, temparray);	
											ds_list_insert(other.WC_consolelist, 0, setmsg + "array " + string(tempvar) + " to number " + tempval + " in " + tempobj);
										}
										else if tempval == "undefined" // undefined
										{
											temparray[tempind] = undefined;
												
											variable_instance_set(__tempsomething, tempvar, temparray);
											ds_list_insert(other.WC_consolelist, 0, setmsg + "array " + string(tempvar) + " to undefined");
										}
										else // string
										{
											temparray[tempind] = string_replace(tempval, "\\", "");
												
											variable_instance_set(__tempsomething, tempvar, temparray);
											ds_list_insert(other.WC_consolelist, 0, setmsg + "array " + string(tempvar) + " to string " + temparray[tempind] + " in " + tempobj);
										}
							
										// set variable if frozen
										for (i = 0; i < array_length(other.WC_frozenobj); i++)
										{
											if __tempsomething == other.WC_frozenobj[i] && tempvar == other.WC_frozenvar[i]
												other.WC_frozenval[i] = variable_instance_get(__tempsomething, tempvar);
										}
									}
								}
							}
						}
					}
				}
			}
			break;
		
		case "panic":
		case "pizzatime":
		case "escape": // pt exclusive
			if global.panic
			{
				// it is no longer pizza time
				with obj_camera
					alarm[1] = -1;
				instance_destroy(obj_itspizzatime);
				global.panic = false;
			}
			else
			{
				// activate pizza time
				with instance_create(room_width, room_height + 2000, obj_hungrypillar)
				{
					event_perform(ev_destroy, 0);
					instance_destroy(id, false);
				}
			}
		
			// command
			arg1 = ds_list_find_value(arg, 1);
			if is_undefined(arg1)
			{
				if WC_consoleopen
				{
					if global.panic
						console_log("Toggled Pizza Time ON with default timer");
					else
						console_log("Toggled Pizza Time OFF");
				}
			}
			else
			{
				arg2 = ds_list_find_value(arg, 2);
				if is_undefined(arg2)
					arg2 = "0";
					
				if string_length(string_digits(arg1)) + string_count("-", arg1) + string_count(".", arg1) == string_length(arg1)
				{
					if string_length(string_digits(arg2)) + string_count("-", arg2) + string_count(".", arg2) == string_length(arg2)
					{
						global.minutes = real(arg1);
						global.seconds = real(arg2);
					
						if WC_consoleopen
						{
							if global.panic
								console_log("Toggled Pizza Time ON with timer " + arg1 + ":" + arg2);
							else
								console_log("Toggled Pizza Time OFF");
						}
						global.fill = ((global.minutes * 60 + global.seconds) * 60) * obj_chunktimer.fillrate;
					}
					else
					{
						WC_consoleopen = true;
						console_log("Seconds parameter must be a number");
					}
				}
				else
				{
					WC_consoleopen = true;
					console_log("Minutes parameter must be a number");
				}
			}
			global.maxwave = (global.minutes * 60 + global.seconds) * 60;
			break;
			
		case "snickchallenge":
		case "snickschallenge": // pt exclusive
			if global.snickchallenge
			{
				with obj_camera
					alarm[1] = -1;
				global.snickchallenge = false;
				console_log("Toggled Snick Challenge OFF");
			}
			else
			{
				global.wave = 0;
				global.maxwave = ((global.minutes * 60) + global.seconds) * 60;
					
				if global.panicbg
					scr_panicbg_init();
					
				global.snickchallenge = true;
				global.collect = 10000;
					
				with obj_camera
				{
					alarm[1] = 60;
					global.seconds = 59;
					global.minutes = 9;
				}
					
				if !instance_exists(obj_snickexe)
					instance_create(room_width / 2, -10, obj_snickexe);
					
				arg1 = ds_list_find_value(arg, 1)
				
				if is_undefined(arg1)
					console_log("Toggled Snick Challenge ON");
				else
				{
					arg2 = ds_list_find_value(arg, 2);
					if is_undefined(arg2)
						arg2 = "0";
						
					if string_length(string_digits(arg1)) + string_count("-", arg1) + string_count(".", arg1) == string_length(arg1)
					{
						if string_length(string_digits(arg2)) + string_count("-", arg2) + string_count(".", arg2) == string_length(arg2)
						{
							global.minutes = real(arg1);
							global.seconds = real(arg2);
							console_log("Toggled Snick Challenge ON with timer " + arg1 + ":" + arg2);
						}
						else
						{
							WC_consoleopen = true;
							console_log("Seconds parameter must be a number");
						}
					}
					else
					{
						WC_consoleopen = true;
						console_log("Minutes parameter must be a number");
					}
				}
			}
			global.maxwave = (global.minutes * 60 + global.seconds) * 60;
			break
			
		case "freeze":
		case "unfreeze":
			tempobj = ds_list_find_value(arg, 1);
			tempvar = ds_list_find_value(arg, 2);
		
			if is_undefined(tempobj)
			{
				console_log(lang_str("online.usage") + ": freeze global VARIABLE or freeze OBJECT FIND VARIABLE");
			}
			else
			{
				// variable parameter left out
				if is_undefined(tempvar)
				{
					console_log(lang_str("online.usage") + ": freeze global VARIABLE or freeze OBJECT FIND VARIABLE");
					WC_consoleopen = true;
				}
			
				// global
				else if tempobj == "global"
				{
					tempvar = string_replace(tempvar, "global.", "");
					if variable_global_exists(tempvar)
					{
						__tempsomething = false;
						frz = array_length_1d(WC_frozenobj);
						for (i = 0; i < frz; i++)
						{
							// unfreeze variable
							if "__WC_GLOBAL__" + tempvar == WC_frozenvar[i]
							{
								WC_frozenobj[i] = noone;
								WC_frozenvar[i] = undefined;
								WC_frozenval[i] = undefined;
								WC_consoleenter = "";
								
								console_log("UNFROZEN global." + tempvar);
								__tempsomething = true;
							}
						}
						if !__tempsomething
						{
							for (i = 0; i < frz; i++)
							{
								// find undefined slot to replace
								if WC_frozenvar[i] == undefined
								{
									frz = i;
									break;
								}
							}
						
							WC_frozenobj[frz] = noone;
							WC_frozenvar[frz] = "__WC_GLOBAL__" + tempvar;
							WC_frozenval[frz] = variable_global_get(tempvar);
							console_log("Frozen global." + tempvar + " to value of " + string(WC_frozenval[frz]));
						}
					}
				
					// variable doesn't exist
					else
					{
						WC_consoleopen = true;
						console_log("Global variable global." + tempvar + " doesn't exist. Check for typos");
					}
				}
				
				// object
				else
				{
					temp_objfind = ds_list_find_value(arg, 2);
						
					if string_length(string_digits(temp_objfind)) + string_count("-", temp_objfind) + string_count(".", temp_objfind) != string_length(temp_objfind)
					&& string_lower(temp_objfind) != "all"
					{
						console_log("FIND parameter must be a number");
						WC_consoleopen = true;
					}
					else if is_undefined(temp_objfind)
					{
						console_log(lang_str("online.usage") + ": freeze OBJECT FIND VARIABLE");
						WC_consoleopen = true;
					}
					else
					{
						tempvar = ds_list_find_value(arg, 3);
						tempvar = string_replace(tempvar, "global.", "");
						WC_tempobj = asset_get_index(tempobj);
					
						if string_lower(temp_objfind) == "all"
							temp_objfind = all;
					
						if is_undefined(tempvar)
						{
							console_log(lang_str("online.usage") + ": freeze OBJECT FIND VARIABLE");
							WC_consoleopen = true;
						}
						else if WC_tempobj == -1
						{
							console_log("Asset " + tempobj + " doesn't exist. Check for typos");
							WC_consoleopen = true;
						}
						else if asset_get_type(tempobj) != asset_object
						{
							console_log("The asset " + tempobj + " isn't an object");
							WC_consoleopen = true;
						}
						else
						{
							if temp_objfind != all
								WC_tempobj = instance_find(WC_tempobj, real(temp_objfind));
						
							if !instance_exists(WC_tempobj)
							{
								console_log("Instance " + tempobj + " doesn't exist in room");
								WC_consoleopen = true;
							}
							else
							{
								if temp_objfind == all
								{
									with WC_tempobj
									{
										if variable_instance_exists(self, tempvar)
										{
											frz = array_length_1d(other.WC_frozenobj);
											__tempsomething = false;
											for (i = 0; i < frz; i++)
											{
												// unfreeze variable
												if self == other.WC_frozenobj[i] && tempvar == other.WC_frozenvar[i]
												{
													other.WC_frozenobj[i] = noone;
													other.WC_frozenvar[i] = undefined;
													other.WC_frozenval[i] = undefined;
													ds_list_insert(other.WC_consolelist, 0, "UNFROZEN variable " + tempvar + " in object " + object_get_name(object_index));
													__tempsomething = true;
												}
											}
											if !__tempsomething
											{
												for (i = 0; i < frz; i++)
												{
													// find undefined slot to replace
													if other.WC_frozenvar[i] == undefined
														frz = i;
												}
							
												other.WC_frozenobj[frz] = self;
												other.WC_frozenvar[frz] = tempvar;
												other.WC_frozenval[frz] = variable_instance_get(self, tempvar);
												ds_list_insert(other.WC_consolelist, 0, "Frozen variable " + tempvar + " in object " + object_get_name(object_index) + " to value of " + string(other.WC_frozenval[frz]));
											}
										}
										else
										{
											WC_consoleopen = true;
											console_log("Variable " + tempvar + " doesn't exist. Check for typos");
										}
									}
								}
								else if variable_instance_exists(WC_tempobj, tempvar)
								{
									frz = array_length_1d(WC_frozenobj);
									__tempsomething = false;
									for (i = 0; i < frz; i++)
									{
										// unfreeze variable
										if WC_tempobj == WC_frozenobj[i] && tempvar == WC_frozenvar[i]
										{
											WC_frozenobj[i] = noone;
											WC_frozenvar[i] = undefined;
											WC_frozenval[i] = undefined;
											console_log("UNFROZEN variable " + tempvar + " in object " + object_get_name(WC_tempobj.object_index));
											__tempsomething = true;
										}
									}
									if !__tempsomething
									{
										for (i = 0; i < frz; i++)
										{
											// find undefined slot to replace
											if WC_frozenvar[i] == undefined
												frz = i;
										}
							
										WC_frozenobj[frz] = WC_tempobj;
										WC_frozenvar[frz] = tempvar;
										WC_frozenval[frz] = variable_instance_get(WC_tempobj, tempvar);
										console_log("Frozen variable " + tempvar + " in object " + object_get_name(WC_tempobj.object_index) + " to value of " + string(WC_frozenval[frz]));
									}
								}
								else
								{
									WC_consoleopen = true;
									console_log("Variable " + tempvar + " doesn't exist. Check for typos");
								}
							}
						}
					}
				}
			}
			break
			
		case "unfreezeall":
			for (i = 0; i < array_length_1d(WC_frozenvar); i++)
			{
				WC_frozenobj[i] = noone;
				WC_frozenvar[i] = undefined;
				WC_frozenval[i] = undefined;
			}
			WC_frozenvar[0] = "";
			WC_frozenval[0] = "";
			console_log("Unfrozen all variables");
			break;
		
		/*
		case "freezeall":
			with all
			{
				if id != other.id
				{
					var __tempsomething = variable_instance_get_names(id);
					for(var i = 0; i < array_length_1d(__tempsomething); i++)
					{
						var ind = array_length_1d(other.WC_frozenobj);
						other.WC_frozenobj[ind] = self;
						other.WC_frozenvar[ind] = __tempsomething[i];
						other.WC_frozenval[ind] = variable_instance_get(id, __tempsomething[i]);
					}
				}
			}
			
			__tempsomething = variable_instance_get_names(global);
			for(var i = 0; i < array_length_1d(__tempsomething); i++)
			{
				var ind = array_length_1d(other.WC_frozenobj);
				other.WC_frozenobj[ind] = noone;
				other.WC_frozenvar[ind] = "__WC_GLOBAL__" + __tempsomething[i];
				other.WC_frozenval[ind] = variable_global_get(__tempsomething[i]);
			}
			
			console_log("Frozen all variables");
			break;
		*/
			
		case "showhidden":
		case "showall":
		case "showinvisible":
			WC_showinvisible = !WC_showinvisible;
			if WC_showinvisible && WC_consoleopen
				console_log("Now showing invisible objects");
			break
			
		case "script":
		case "scr":
			tempobj = ds_list_find_value(arg, 1);
			temp_objfind = ds_list_find_value(arg, 2);
			tempscript = ds_list_find_value(arg, 3);
				
			if is_undefined(tempobj)
			{
				console_log(lang_str("online.usage") + ": script OBJECT FIND SCRIPT ARGUMENTS")
			}
			else
			{
				if is_undefined(temp_objfind) or is_undefined(tempscript)
				{
					console_log(lang_str("online.usage") + ": script OBJECT FIND SCRIPT ARGUMENTS");
					WC_consoleopen = true;
				}
				else if string_length(string_digits(temp_objfind)) + string_count("-", temp_objfind) + string_count(".", temp_objfind) != string_length(temp_objfind)
				{
					console_log("FIND parameter must be a number");
					WC_consoleopen = true;
				}
				else
				{
					__tempsomething = asset_get_index(tempobj);
					if __tempsomething == -1
					{
						console_log("Asset " + tempobj + " doesn't exist. Check for typos");
						WC_consoleopen = true;
					}
					else if asset_get_type(tempobj) != asset_object
					{
						console_log("The asset " + tempobj + " isn't an object");
						WC_consoleopen = true;
					}
					else
					{
						__tempsomething = instance_find(__tempsomething, real(temp_objfind));
						if !instance_exists(__tempsomething)
						{
							console_log("Instance " + tempobj + " doesn't exist in room");
							WC_consoleopen = true;
						}
						else
						{
							var get_script = asset_get_index(tempscript);
							if get_script == -1
							{
								console_log("Asset " + tempscript + " doesn't exist. Check for typos");
								WC_consoleopen = true;
							}
							else if asset_get_type(tempscript) != asset_script
							{
								console_log("The asset " + tempscript + " isn't a script");
								WC_consoleopen = true;
							}
							else
							{
								scrarg[0] = ds_list_find_value(arg, 4);
								scrarg[1] = ds_list_find_value(arg, 5);
								scrarg[2] = ds_list_find_value(arg, 6);
								scrarg[3] = ds_list_find_value(arg, 7);
								scrarg[4] = ds_list_find_value(arg, 8);
								scrarg[5] = ds_list_find_value(arg, 9);
								scrarg[6] = ds_list_find_value(arg, 10);
								scrarg[7] = ds_list_find_value(arg, 11);
								scrarg[8] = ds_list_find_value(arg, 12);
								scrarg[9] = ds_list_find_value(arg, 13);
								
								for (i = 0; i <= 9; i++)
								{
									if !is_undefined(scrarg[i])
									{
										if asset_get_index(scrarg[i]) != -1 // asset
											scrarg[i] = asset_get_index(scrarg[i]);
										else if string_length(string_digits(scrarg[i])) + string_count("-", scrarg[i]) + string_count(".", scrarg[i]) == string_length(scrarg[i])
										// number
											scrarg[i] = real(scrarg[i]);
										else if scrarg[i] == "undefined" // undefined
											scrarg[i] = undefined;
									}
								}
							
								with __tempsomething
									script_execute(get_script, scrarg[0], scrarg[1], scrarg[2], scrarg[3], scrarg[4], scrarg[5], scrarg[6], scrarg[7], scrarg[8], scrarg[9]);
								console_log("Executed script " + tempscript + " on " + tempobj);
							}
						}
					}
				}
			}
			break;
			
		case "extrahud":
		case "debughud":
		case "debugview":
			arg1 = ds_list_find_value(arg, 1);	
			if is_undefined(arg1)
			{
				WC_debuginfo = !WC_debuginfo;
				if WC_consoleopen
				{
					if WC_debuginfo
						console_log("Debug view ON");
					else
						console_log("Debug view OFF");
				}
					
				if !WC_debuginfo
					WC_debugselected = noone;
				show_debug_overlay(WC_debuginfo);				
			}
			else
			{
				WC_debuginfo = true;
				if arg1 == "global"
				{
					if WC_debugselected == global
						WC_debugselected = noone;
					else
						WC_debugselected = global
						
					WC_debugvarstart = 0;
					console_log("Now showing global variables with debug view");
				}
				else
				{
					tempobj = ds_list_find_value(arg, 1);
					temp_objfind = ds_list_find_value(arg, 2);
						
					if is_undefined(tempobj) or is_undefined(temp_objfind)
					{
						console_log(lang_str("online.usage") + ": debugview OBJECT FIND");
						WC_consoleopen = true;
					}	
					else if string_length(string_digits(temp_objfind)) + string_count("-", temp_objfind) + string_count(".", temp_objfind) != string_length(temp_objfind)
					{
						console_log("FIND parameter must be a number");
						WC_consoleopen = true;
					}
					else
					{
						__tempsomething = asset_get_index(tempobj)
						if __tempsomething == -1
						{
							console_log("Asset " + tempobj + " doesn't exist. Check for typos");
							WC_consoleopen = true;
						}
						else if asset_get_type(tempobj) != asset_object
						{
							console_log("The asset " + tempobj + " isn't an object");
							WC_consoleopen = true;
						}
						else
						{
							__tempsomething = instance_find(__tempsomething, real(temp_objfind))
							if !instance_exists(__tempsomething)
							{
								console_log("Instance " + tempobj + " doesn't exist in room");
								WC_consoleopen = true;
							}
							else
							{
								if WC_debugselected == __tempsomething
									WC_debugselected = noone;
								else
									WC_debugselected = __tempsomething;
						
								WC_debugvarstart = 0;
								console_log("Now debugging " + tempobj);
							}
						}
					}
				}
				show_debug_overlay(WC_debuginfo);
			}
			break;
			
		case "clearsaveroom":
		case "resetsaveroom":
		case "extreset": // pt exclusive
			if variable_global_exists("saveroom") && ds_exists(global.saveroom, ds_type_list)
				ds_list_clear(global.saveroom);
			if variable_global_exists("baddieroom") && ds_exists(global.baddieroom, ds_type_list)
				ds_list_clear(global.baddieroom);
			if variable_global_exists("baddietomb") && ds_exists(global.baddietomb, ds_type_list) // april build
				ds_list_clear(global.baddietomb);
			
			with obj_player
				targetDoor = "none";
			with all
				if !persistent && id != other.id then instance_destroy(id, false);
			
			room_restart();
				
			if !WC_consoleopen
			{
				with obj_tv
				{
					showtext = true;
					message = "SAVED ROOM RESET";
					alarm[0] = 100;
				}
			}
			else
				console_log("Saveroom and Baddieroom reset");
			break
		
		case "delete":
		case "destroy":
			arg1 = ds_list_find_value(arg, 1);
			if is_undefined(arg1)
			{
				console_log(lang_str("online.usage") + ": delete OBJECT");
			}
			else
			{
				__tempsomething = asset_get_index(arg1);
				arg2 = ds_list_find_value(arg, 2);
				if is_undefined(arg2)
				{
					if __tempsomething == -1
					{
						console_log("Asset " + arg1 + " doesn't exist. Check for typos");
						WC_consoleopen = true;
					}
					else if asset_get_type(arg1) != asset_object
					{
						console_log("The asset " + arg1 + " isn't an object");
						WC_consoleopen = true;
					}
					else if instance_number(__tempsomething) == 0
					{
						console_log("The object " + arg1 + " isn't in the room");
						WC_consoleopen = true;
					}
					else if instance_number(__tempsomething) >= 1
					{
						if __tempsomething == object_index
						{
							console_log("You shouldnt do that");
							WC_consoleopen = true;
						}
						else
						{
							console_log("Deleted " + string(instance_number(__tempsomething)) + " objects with name or parent " + arg1);
							instance_destroy(__tempsomething);
						}
					}
				}
				else if string_digits(arg2) == arg2
				{
					temp_objfind = real(arg2);
					__tempsomething = instance_find(__tempsomething, temp_objfind);
				
					if __tempsomething == noone
					{
						console_log("The object " + arg1 + " isn't in the room");
						WC_consoleopen = true;
					}
					else
					{
						if __tempsomething == self
						{
							console_log("You shouldnt do that");
							WC_consoleopen = true;
						}
						else
						{
							console_log("Deleted object " + object_get_name(__tempsomething.object_index));
							instance_destroy(__tempsomething);
						}
					}
				}
				else
				{
					console_log("FIND parameter must be a whole number");
					WC_consoleopen = true;
				}
			}
			break;
			
		case "character":
		case "char": // pt exclusive
			if instance_exists(obj_player)
			{
				arg1 = ds_list_find_value(arg, 1);
				
				if is_undefined(arg1)
				{
					console_log(lang_str("online.usage") + ": character STRING");
					WC_consoleopen = true;
				}
				else
				{
					arg1 = string_upper(arg1);
					arg2 = ds_list_find_value(arg, 2);
					var __tempsomething = "";
					
					if !is_undefined(arg2)
					{
						arg2 = string_upper(arg2);
						if arg2 == "P"
							__tempsomething = " with Peppino sprites";
						else if arg2 == "N"
							__tempsomething = " with Noise sprites";
						else if arg2 == "V"
							__tempsomething = " with Vigilante sprites";
						else if arg2 == "S"
							__tempsomething = " with Snick sprites";
						else if arg2 == "M"
							__tempsomething = " with Pepperman sprites";
						else if arg2 == "SP" // pt online exclusive
							__tempsomething = " with Pizzelle sprites";
						else if arg2 == "SN" // pt online exclusive
							__tempsomething = " with Pizzano sprites";
						else if arg2 == "PP" // pt online exclusive
							__tempsomething = " with Pissino sprites";
						else
						{
							__tempsomething = " with unchanged sprites";
							arg2 = ds_list_find_value(arg, 2);
						}
					
						obj_player.character = arg2;
					}
					else
						obj_player.character = arg1;
				
					with obj_player
						scr_characterspr();
					
					obj_player.character = arg1;
				
					if arg1 == "P"
						arg1 = "Peppino";
					else if arg1 == "N"
						arg1 = "Noise";
					else if arg1 == "V"
						arg1 = "Vigilante";
					else if arg1 == "S"
						arg1 = "Snick";
					else if arg1 == "M"
						arg1 = "Pepperman";
					else if arg1 == "SP" // pt online exclusive
						arg1 = "Pizzelle";
					else if arg1 == "SN" // pt online exclusive
						arg1 = "Pizzano";
					else if arg1 == "PP" // pt online exclusive
						arg1 = "Pissino";
					else
					{
						arg1 = ds_list_find_value(arg, 1);
						obj_player.character = arg1;
					}
				
					console_log("Set player 1 character to " + arg1 + __tempsomething);
				}
			}
			else
			{
				console_log("Player 1 object doesn't exist");
				WC_consoleopen = true;
			}
			break;
			
		case "resetwindow": // pt exclusive
			if global.option_resolution == 0
				window_set_size(480, 270);
			if global.option_resolution == 1
				window_set_size(960, 540);
			if global.option_resolution == 2
				window_set_size(1920, 1080);
			
			if !WC_consoleopen
			{
				with obj_tv
				{
					showtext = true;
					message = "WINDOW RESOLUTION RESET";
					alarm[0] = 100;
				}
			}
			else
				console_log("Window resolution reset");
			break;
	
		case "beatlevel": // pt exclusive
			WC_consoleopen = false;
			// pt exclusive
			if instance_exists(obj_player)
			{
				fmod_stop_all();
		
				if obj_player.character != "S"
				{
					global.panic = true;
					global.snickchallenge = false;
			
					obj_player.state = states.normal;
					obj_player.grounded = true;
					obj_player.key_up = true;
					obj_player.key_up2 = true;
				
					with obj_player
					{
						with instance_create_depth(obj_player.x, obj_player.y, 0, obj_exitgate)
						{
							image_index = 1;
							visible = false;
							event_perform(ev_collision, obj_player);
						}
					}
				}
				else
				{
					global.seconds = 1;
				
					global.panic = true;
					global.snickchallenge = false;
				
					with instance_create(obj_player.x, obj_player.y, obj_snicklevelend)
						image_index = image_number - 1;
				}
			}
			else
				show_message("Player 1 object doesn't exist");
			break;
		
		/*
		case "collisionview":
		case "showcollision":
		case "showcol": // pt exclusive
			WC_showcollision = !WC_showcollision;
			
			if !WC_consoleopen
			{
				with obj_tv
				{
					showtext = true;
					alarm[0] = 100;
				
					if other.WC_showcollision
						message = "COLLISION VIEW ON";
					else
						message = "COLLISION VIEW OFF";
				}
			}
			else
			{
			  if WC_showcollision
				  console_log("Collision view ON");
			  else
				  console_log("Collision view OFF");
			}
			break
		*/
		
		case "checkvar":
			tempobj = ds_list_find_value(arg, 1);
			tempvar = ds_list_find_value(arg, 2);
				
			if is_undefined(tempvar) or is_undefined(tempobj)
			{
				console_log(lang_str("online.usage") + ": checkvar global VARIABLE or checkvar OBJECT FIND VARIABLE");
				WC_consoleopen = true;
			}
			else if tempobj == "global"
			{
				tempvar = string_replace(tempvar, "global.", "");
					
				if variable_global_exists(tempvar)
				{
					if WC_consoleopen
						console_log("Global variable global." + tempvar + " is " + string(variable_global_get(tempvar)));
					else // pt exclusive
					{
						with obj_tv
						{
							showtext = true;
							alarm[0] = 100;
							message = string_upper(string(variable_global_get(tempvar)));
						}
					}
				}
				else
				{
					console_log("Global variable global." + tempvar + " doesn't exist. Check for typos");
					WC_consoleopen = true;
				}
			}
			else
			{
				temp_objfind = ds_list_find_value(arg, 2);
					
				if string_length(string_digits(temp_objfind)) + string_count("-", temp_objfind) + string_count(".", temp_objfind) != string_length(temp_objfind)
				{
					console_log("FIND parameter must be a number");
					WC_consoleopen = true;
				}	
				else if is_undefined(temp_objfind)
				{
					console_log(lang_str("online.usage") + ": checkvar OBJECT FIND VARIABLE");
					WC_consoleopen = true;
				}
				else
				{
					tempvar = ds_list_find_value(arg, 3);
					__tempsomething = asset_get_index(tempobj);
				
					if is_undefined(tempvar)
					{
						console_log(lang_str("online.usage") + ": checkvar OBJECT FIND VARIABLE");
						WC_consoleopen = true;
					}
					else if __tempsomething == -1
					{
						console_log("Asset " + tempobj + " doesn't exist. Check for typos");
						WC_consoleopen = true;
					}
					else if asset_get_type(tempobj) != asset_object
					{
						console_log("The asset " + tempobj + " isn't an object");
						WC_consoleopen = true;
					}
					else
					{
						__tempsomething = instance_find(__tempsomething, real(temp_objfind));
						if !instance_exists(__tempsomething)
						{
							console_log("Instance " + tempobj + " doesn't exist in room");
							WC_consoleopen = true;
						}
						else if variable_instance_exists(__tempsomething, tempvar)
						{
							if WC_consoleopen
								console_log(object_get_name(__tempsomething.object_index) + "." + tempvar + " is " + string(variable_instance_get(__tempsomething, tempvar)));
							else // pt exclusive
							{
								with obj_tv
								{
									showtext = true;
									alarm[0] = 100;
									message = string_upper(string(variable_instance_get(__tempsomething, tempvar)));
								}
							}
						}
						else
						{
							WC_consoleopen = true;
							console_log("Variable " + tempvar + " doesn't exist. Check for typos");
						}
					}
				}
			}
			break;
			
		case "monitorvar":
		case "monitorvariable":
		case "monitor":
			tempobj = ds_list_find_value(arg, 1);
			if is_undefined(tempobj)
			{
				if WC_varmonitor != undefined
				{
					console_log("Stopped monitoring variables");
					WC_varmonitor = undefined;
					WC_varobj = undefined;
				}
				else
				{
					console_log(lang_str("online.usage") + ": monitorvar global VARIABLE or monitorvar OBJECT FIND VARIABLE");
				}
			}
			else
			{
				tempvar = ds_list_find_value(arg, 2);
				if is_undefined(tempvar)
				{
					console_log(lang_str("online.usage") + ": monitorvar global VARIABLE or monitorvar OBJECT FIND VARIABLE");
					WC_consoleopen = true;
				}
				else if tempobj == "global"
				{
					tempvar = string_replace(tempvar, "global.", "");
					if variable_global_exists(tempvar)
					{
						WC_varmonitor = tempvar;
						WC_varobj = global;
						console_log("Now monitoring global." + tempvar);
					}
					else
					{
						WC_consoleopen = true;
						console_log("Global variable global." + tempvar + " doesn't exist. Check for typos");
					}
				}
				else
				{
					temp_objfind = ds_list_find_value(arg, 2);
				
					if is_undefined(temp_objfind)
					{
						console_log(lang_str("online.usage") + ": monitorvar global VARIABLE or monitorvar OBJECT FIND VARIABLE");
						WC_consoleopen = true;
					}
					else if string_length(string_digits(temp_objfind)) + string_count("-", temp_objfind) + string_count(".", temp_objfind) != string_length(temp_objfind)
					{
						console_log("FIND parameter must be a number");
						WC_consoleopen = true;
					}	
					else
					{
						tempvar = ds_list_find_value(arg, 3);
						__tempsomething = asset_get_index(tempobj);
						
						if is_undefined(tempvar)
						{
							console_log(lang_str("online.usage") + ": monitorvar global VARIABLE or monitorvar OBJECT FIND VARIABLE");
							WC_consoleopen = true;
						}
						else if __tempsomething == -1
						{
							console_log("Asset " + tempobj + " doesn't exist. Check for typos");
							WC_consoleopen = true;
						}
						else if asset_get_type(tempobj) != asset_object
						{
							console_log("The asset " + tempobj + " isn't an object");
							WC_consoleopen = true;
						}
						else
						{
							__tempsomething = instance_find(__tempsomething, real(temp_objfind));	
							if !instance_exists(__tempsomething)
							{
								console_log("Instance " + tempobj + " doesn't exist in room");
								WC_consoleopen = true;
							}
							else if variable_instance_exists(__tempsomething, tempvar)
							{
								WC_varmonitor = tempvar;
								WC_varobj = __tempsomething;
								console_log("Now monitoring " + object_get_name(__tempsomething.object_index) + "." + tempvar);
							}
							else
							{
								WC_consoleopen = true;
								console_log("Variable " + tempvar + " doesn't exist. Check for typos");
							}
						}
					}
				}
			}
			break;
		
		case "list":
		case "lookup":
			arg1 = ds_list_find_value(arg, 1);
			if is_undefined(arg1)
			{
				console_log(lang_str("online.usage") + ": list ASSET SORT");
				WC_consoleopen = true;
			}
			else
			{
				if string_upper(arg1) == "ROOM"
				{
					if ds_exists(WC_assetlist, ds_type_list)
						ds_list_destroy(WC_assetlist);
					WC_assetlist = ds_list_create();
					
					// retrieve room list
					for(var i = 0; room_exists(i); i++)
						ds_list_add(WC_assetlist, room_get_name(i));
					
					WC_assetfinder = 0;
					WC_consoleopen = false;
				}
				else if string_upper(arg1) == "OBJECT"
				{
					if ds_exists(WC_assetlist, ds_type_list)
						ds_list_destroy(WC_assetlist);
					WC_assetlist = ds_list_create();
					
					// retrieve room list
					for(var i = 0; object_exists(i); i++)
						ds_list_add(WC_assetlist, object_get_name(i));
					
					WC_assetfinder = 1;
					WC_consoleopen = false;
				}
				else
				{
					WC_assetfinder = -1;
					
					console_log("Asset list for " + arg1 + " doesn't exist. Check for typos");
					WC_consoleopen = true;
				}
				keyboard_clear(vk_enter);
				
				if WC_assetfinder > -1
				{
					WC_consolescroll = 0;
					
					arg2 = string_lower(string(ds_list_find_value(arg, 2)));
					if arg2 == "true" or arg2 == "1"
						ds_list_sort(WC_assetlist, true);
					WC_assetsel = 0;
				}
			}
			break;
		
		case "facesolid":
			global.facesolids = !global.facesolids;
			console_log("Funny mode " + (global.facesolids ? "ENABLED" : "DISABLED"));
			break;
		
		case "bind":
			arg1 = ds_list_find_value(arg, 1);
			arg2 = ds_list_find_value(arg, 2);
		
			if is_undefined(arg1) or is_undefined(arg2)
			{
				console_log(lang_str("online.usage") + ": bind KEY COMMAND");
				WC_consoleopen = true;
			}
			else
			{
				var key = scr_wckeycode(arg1);
				var finalkey = key[0];
				var keycode = key[1];
				
				if finalkey != -1
				{
					var command = string_replace(commandargs, arg1 + " ", "");
					if command == "openconsole"
					{
						WC_togglekey = finalkey;
						console_log("Rebound " + (keycode ? "keycode " : "") + string_upper(arg1) + " to open the console");
					}
					else
					{
						ds_list_add(WC_bindkey, finalkey);
						ds_list_add(WC_bindmap, command);
						console_log("Bound " + (keycode ? "keycode " : "") + string_upper(arg1) + " to execute " + command);
					}
				}
			}
			break;
		
		case "unbind":
			arg1 = ds_list_find_value(arg, 1);
			if !is_undefined(arg1)
			{
				if arg1 == all
					scr_wcevaluate("unbindall");
				else
				{
					var finalkey = scr_wckeycode(string_upper(arg1))[0];
					
					__tempsomething = false;
					for (i = 0; i < ds_list_size(WC_bindkey); i++)
					{
						if ds_list_find_value(WC_bindkey, i) == finalkey
						{
							ds_list_delete(WC_bindkey, i);
							ds_list_delete(WC_bindmap, i);
							__tempsomething = true;
							i = 0;
						}
					}
					
					if !__tempsomething
					{
						console_log("Bind not found. You can try unbinding all.");
						WC_consoleopen = true;
					}
					else
						console_log("Unbinded " + arg1);
				}
			}
			else
			{
				console_log(lang_str("online.usage") + ": unbind KEY");
				WC_consoleopen = true;
			}
			break;
			
		case "unbindall":
			ds_list_clear(WC_bindkey);
			ds_list_clear(WC_bindmap);
			console_log("Unbinded all keys");
			break;
			
		case "%startup": // pt exclusive
			var wc_save;
			if file_exists("wc_save")
			{
				// read savefile
				wc_save = file_text_open_read("wc_save");
				
				if WC_saveversion != file_text_read_real(wc_save)
				{
					// different version
					file_delete("wc_save");
					ds_list_destroy(arg);
					exit;
				}
			
				var colr, colg, colb;
				file_text_readln(wc_save);
				colr = clamp(file_text_read_real(wc_save), 0, 255);
				file_text_readln(wc_save);
				colg = clamp(file_text_read_real(wc_save), 0, 255);
				file_text_readln(wc_save);
				colb = clamp(file_text_read_real(wc_save), 0, 255);
				WC_consolecolor = make_colour_rgb(colr, colg, colb);
					
				file_text_readln(wc_save);
				WC_maxconsolebottom = clamp(file_text_read_real(wc_save), 20, 540);
					
				file_text_readln(wc_save);
				ds_list_read(WC_bindkey, file_text_read_string(wc_save));
				file_text_readln(wc_save);
				ds_list_read(WC_bindmap, file_text_read_string(wc_save));
					
				file_text_readln(wc_save)
				WC_togglekey = file_text_read_real(wc_save);
			
				file_text_readln(wc_save)
				WC_swapconsolefont = file_text_read_real(wc_save); // pt exclusive, deprecated
			
				file_text_readln(wc_save)
				WC_candrag = file_text_read_real(wc_save);
			
				file_text_readln(wc_save)
				WC_prioritizebaddies = file_text_read_real(wc_save); // pt exclusive
			
				file_text_readln(wc_save)
				WC_draggrid = file_text_read_real(wc_save);
			
				file_text_close(wc_save);
			}
			else
				scr_wcsave();
			break;
			
		case "saveconfig":
		case "save": // pt exclusive
			scr_wcsave();
			
			if !WC_consolesilence
				console_log("Saved settings");
			break;
	
		default: // no command
			WC_consoleopen = true;
			console_log("Invalid command " + arg0);
			break;
	}
	ds_list_destroy(arg);
	
	if WC_consoleopen && WC_consoleenter == eval
		keyboard_string = "";
	keyboard_clear(vk_enter);
}

function scr_wckeycode(key)
{
	var finalkey = -1;
	var keycode = false;
	
	switch string_upper(key)
	{
		case "F1":
			finalkey = vk_f1;
			break;
		case "F2":
			finalkey = vk_f2;
			break;
		case "F3":
			finalkey = vk_f3;
			break;
		case "F4":
			finalkey = vk_f4;
			break;
		case "F5":
			finalkey = vk_f5;
			break;
		case "F6":
			finalkey = vk_f6;
			break;
		case "F7":
			finalkey = vk_f7;
			break;
		case "F8":
			finalkey = vk_f8;
			break;
		case "F9":
			finalkey = vk_f9;
			break;
		case "F10":
			finalkey = vk_f10;
			break;
		case "F11":
			finalkey = vk_f11;
			break;
		case "F12":
			finalkey = vk_f12;
			break;
		case "BACKSPACE":
			finalkey = vk_backspace;
			break;
		case "SPACE":
			finalkey = vk_space;
			break;
		case "TAB":
			finalkey = vk_tab;
			break;
		case "SHIFT":
			finalkey = vk_shift;
			break;
		case "CONTROL":
			finalkey = vk_control;
			break;
		case "UP":
			finalkey = vk_up;
			break;
		case "DOWN":
			finalkey = vk_down;
			break;
		case "LEFT":
			finalkey = vk_left;
			break;
		case "RIGHT":
			finalkey = vk_right;
			break;
		case "ESCAPE":
		case "ESC":
			finalkey = vk_escape;
			break;
					
		default:
			// keycode
			if string_digits(key) == key && real(key) > 9
			{
				keycode = true;
				finalkey = real(key);
			}
			else
			{
				// string
				if string_length(key) > 1
				{
					console_log("Unknown key " + string(key));
					WC_consoleopen = true;
				}
				else
					finalkey = ord(string_upper(key));
			}
			break;
	}
	return [finalkey, keycode];
}