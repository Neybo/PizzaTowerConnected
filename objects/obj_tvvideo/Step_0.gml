if !opened
	return;
	
scr_getinput(true)

if key_escape
{
	opened = false
	exit;
}

if keyboard_check_pressed(vk_enter)
{
	if input == ""
	{
		with obj_roomname
		{
			showtext = true;
			message = "CANT BE NOTHING"
			alarm[0] = 200;
			scr_soundeffect(sfx_pephurt)
		}
		return;
	}	
    alarm[0] = 1
	opened = false
}

if keyboard_check(vk_control)
{
	if keyboard_check_pressed(ord("V"))
	{
		if (clipboard_has_text())
			input = clipboard_get_text()
		else
		{
			with obj_roomname
			{
				showtext = true;
				message = "NO TEXT FOUND ON CLIPBOARD"
				alarm[0] = 200;
				scr_soundeffect(sfx_pephurt)
			}
		}
	}
	if keyboard_check_pressed(ord("F"))
	{
		var file = get_open_filename("mp4 files|*.mp4|mov files|*.mov|webm files|*.webm|wmv files|*.wmv|mkv files|*.mkv", "")
		if file != ""
		{
			input = file
			alarm[0] = 1
			opened = false
		}
	}
}
if keyboard_check_pressed(vk_backspace)
{
	input = ""
}



