///string_keycheck(key);
function scr_keyname(key)
{
	//Checks the given key and returns it as a string. Also detects vk_constants.
	switch (key)
	{
		case vk_left: return "LEFT"; break;
		case vk_right: return "RIGHT"; break;
		case vk_up: return "UP"; break;
		case vk_down: return "DOWN"; break;
		
		case vk_enter: return "ENTER"; break;
		case vk_escape: return "ESCAPE"; break;
		case vk_space: return "SPACE"; break;
		case vk_shift: return "SHIFT"; break;
		case vk_control: return "CONTROL"; break;
		case vk_alt: return "ALT"; break;
		case vk_backspace: return "BACKSPACE"; break;
		
		case vk_tab: return "TAB"; break;
		case vk_home: return "HOME"; break;
		case vk_end: return "END"; break;
		case vk_delete: return "DELETE"; break;
		case vk_insert: return "INSERT"; break;
		case vk_pageup: return "PAGE UP"; break;
		case vk_pagedown: return "PAGE DOWN"; break;
		case vk_pause: return "PAUSE"; break;
		case vk_printscreen: return "PRINT SCREEN"; break;
		
		case vk_f1: return "F1"; break;
		case vk_f2: return "F2"; break;
		case vk_f3: return "F3"; break;
		case vk_f4: return "F4"; break;
		case vk_f5: return "F5"; break;
		case vk_f6: return "F6"; break;
		case vk_f7: return "F7"; break;
		case vk_f8: return "F8"; break;
		case vk_f9: return "F9"; break;
		case vk_f10: return "F10"; break;
		case vk_f11: return "F11"; break;
		case vk_f12: return "F12"; break;
		
		case vk_numpad0: return "NUMPAD 0"; break;
		case vk_numpad1: return "NUMPAD 1"; break;
		case vk_numpad2: return "NUMPAD 2"; break;
		case vk_numpad3: return "NUMPAD 3"; break;
		case vk_numpad4: return "NUMPAD 4"; break;
		case vk_numpad5: return "NUMPAD 5"; break;
		case vk_numpad6: return "NUMPAD 6"; break;
		case vk_numpad7: return "NUMPAD 7"; break;
		case vk_numpad8: return "NUMPAD 8"; break;
		case vk_numpad9: return "NUMPAD 9"; break;
		
		case vk_multiply: return "MULTIPLY"; break;
		case vk_divide: return "DIVIDE"; break;
		case vk_add: return "ADD"; break;
		case vk_subtract: return "SUBTRACT"; break;
		case vk_decimal: return "DECIMAL"; break;
		
		case -1: return "PRESS KEY"; break;
		
		default: return chr(argument0); break; // Printable characters.
	}
}
function scr_keyfromname(str)
{
	str = string_replace_all(str, " ", "");
	str = string_upper(str);
	
	switch str
	{
		default: return ord(str);
		
		case "SPACE": return vk_space;
		case "UP": return vk_up;
		case "DOWN": return vk_down;
		case "LEFT": return vk_left;
		case "RIGHT": return vk_right;
		case "TAB": return vk_tab;
		case "ENTER": case "RETURN": return vk_enter;
		case "ADD": return vk_add;
		case "ALT": return vk_alt;
		case "ANY": return vk_anykey;
		case "BACKSPACE": return vk_backspace;
		case "CONTROL": case "CTRL": return vk_control;
		case "DECIMAL": return vk_decimal;
		case "ESCAPE": return vk_escape;
		case "SHIFT": return vk_shift;
		case "HOME": return vk_home;
		case "END": return vk_end;
		case "DELETE": case "DEL": return vk_delete;
		case "INSERT": case "INS": return vk_insert;
		case "PAGEUP": return vk_pageup;
		case "PAGEDOWN": return vk_pagedown;
		case "PAUSE": return vk_pause;
		case "PRINTSCREEN": case "IMPPNT": case "PRTSC": case "PRTSCR": case "PRINT": return vk_printscreen;
		case "F1": return vk_f1;
		case "F2": return vk_f2;
		case "F3": return vk_f3;
		case "F4": return vk_f4;
		case "F5": return vk_f5;
		case "F6": return vk_f6;
		case "F7": return vk_f7;
		case "F8": return vk_f8;
		case "F9": return vk_f9;
		case "F10": return vk_f10;
		case "F11": return vk_f11;
		case "F12": return vk_f12;
		case "NUMPAD0": return vk_numpad0;
		case "NUMPAD1": return vk_numpad1;
		case "NUMPAD2": return vk_numpad2;
		case "NUMPAD3": return vk_numpad3;
		case "NUMPAD4": return vk_numpad4;
		case "NUMPAD5": return vk_numpad5;
		case "NUMPAD6": return vk_numpad6;
		case "NUMPAD7": return vk_numpad7;
		case "NUMPAD8": return vk_numpad8;
		case "NUMPAD9": return vk_numpad9;
		case "MULTIPLY": return vk_multiply;
		case "DIVIDE": return vk_divide;
		case "SUBTRACT": case "SUBSTRACT": return vk_subtract;
		
		// these don't work unless using keyboard_check_direct.
		case "LEFTSHIFT": case "LSHIFT": return vk_lshift;
		case "LEFTCONTROL": case "LCONTROL": case "LEFTCTRL": case "LCTRL": return vk_lcontrol;
		case "LEFTALT": case "LALT": return vk_lalt;
		case "RIGHTSHIFT": case "RSHIFT": return vk_rshift;
		case "RIGHTCONTROL": case "RCONTROL": case "RIGHTCTRL": case "RCTRL": return vk_rcontrol;
		case "RIGHTALT": case "RALT": return vk_ralt;
	}
}

