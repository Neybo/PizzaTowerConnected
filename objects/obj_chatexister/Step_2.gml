if check_online() 
&& !(instance_exists(obj_hubelevator) && obj_hubelevator.state != 0)
&& !(instance_exists(obj_wc) && obj_wc.WC_consoleopen)
&& !(instance_exists(obj_dialoguebox))
{
	if keyboard_check_pressed(ord("T")) && !global.__chat && !safe_get(obj_shell, "isOpen")
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