/// @description online && slope
// sync variables
if check_online()
{
	event_user(7)
	// chat
	if state > -1
	&& !instance_exists(obj_choicebase)
	&& !(instance_exists(obj_baseelevator) && obj_baseelevator.state != 0)
	&& !(instance_exists(obj_dialoguebox))
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
			}
			
			/*
			// delete all
			if keyboard_check_pressed(vk_backspace)
				keyboard_string = "";
			*/
			
			// Delete word (Windows' behavior)
			if keyboard_check_pressed(vk_backspace)
			{
				var newlength = string_length(keyboard_string)
				
				if ord(string_char_at(keyboard_string, newlength)) == 127 // what the fuck?
					newlength--
				
				while newlength > 0 && string_char_at(keyboard_string, newlength) == " "
					newlength--;
				while newlength > 0 && string_char_at(keyboard_string, newlength) != " "
					newlength--;			
			
				keyboard_string = string_copy(keyboard_string, 1, newlength);
			}
		}
		if keyboard_check_pressed(ord("T")) && !global.__chat 
		&& !safe_get(obj_shell, "isOpen") 
		&& !(instance_exists(obj_wc) && obj_wc.WC_consoleopen)
		{
			gms_chat_toggle(true);
			keyboard_string = "";
		}
	    if (keyboard_check_pressed(vk_escape) && global.__chat)
		{
	        gms_chat_toggle(0)
			keyboard_key_release(vk_escape)
	        global.__chat_typing = 0
			global.__chat_directclose = 1
			global.__chat_highl = 1
			global.messageselect = -1
		}
		if (ds_list_size(global.messagelist) > 0)
		{
			if (keyboard_check_pressed(vk_up) && global.__chat)
			{
				global.__chat_typing = 1
				if (((ds_list_size(global.messagelist) - global.messageselect) - 1) > 0)
					global.messageselect += 1
				keyboard_string = ds_list_find_value(global.messagelist, ((ds_list_size(global.messagelist) - global.messageselect) - 1))
			}
			else if (keyboard_check_pressed(vk_down) && global.__chat)
			{
				global.__chat_typing = 1
				if (global.messageselect > 0)
					global.messageselect -= 1
			   keyboard_string = ds_list_find_value(global.messagelist, ((ds_list_size(global.messagelist) - global.messageselect) - 1))
			}
		}
	}
}

if global.sloperot && state != states.knightpepslopes && state != states.Sjumpprep
{	
	// TODO: find a better way?
	var slope = instance_place(x, y + 1, obj_slope)
	var slopecheck = slope && scr_slope()// && state != states.backbreaker
	
	
	if !slopecheck
	    img_angle = lerp(img_angle, 0, 0.3)
	else
	{
	    with slope
	    {
			var origin = [x + (16 * abs(image_xscale)), y + (16 * abs(image_yscale))] 
			
			var funny = abs(image_yscale) + abs(image_xscale)
			// pie guy theory, this is shit but it works better
			var dist = distance_between_points(origin[0], origin[1], other.x, other.y) 
			/ (funny / 2 - (funny / 4 * (funny > 12)))
			
			var angle = lerp(0, 45, clamp(24 / dist + 0.05, 0, 1))
			
			other.img_angle = round(lerp(other.img_angle, 
			angle * (image_yscale / image_xscale), 0.3))
		}
	}
}
else
	img_angle = 0;

if (fuckyouteleporter > 0) // ???????? ?? ?? ?? ?? ?? ? ?? ? ?? ? ? ? ?
{
	movespeed = fuckyouteleporter
	fuckyouteleporter = 0
}