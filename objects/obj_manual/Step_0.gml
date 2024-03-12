if !open
{
	i = 0;
	if keyboard_check_pressed(vk_f5)
	&& (!instance_exists(obj_player) or obj_player.state != states.door)
	{
		instance_destroy(obj_wc)
		scr_soundeffect(sfx_step);
		open = true;
	}
	if keyboard_check_pressed(vk_f6) 
	&& (!instance_exists(obj_player) or obj_player.state != states.door)
	&& !(instance_exists(obj_shell) && obj_shell.isOpen)
	{
		url_open("https://discord.gg/vcMjtG8nNC")
	}
}
else
{
	scr_getinput(true);
	if key_right2 && i < sprite_get_number(manualspr) - 1
	{
		i += 1
		scr_soundeffect(sfx_step)
	}

	if -key_left2 && i > 0
	{
		i -= 1
		scr_soundeffect(sfx_step)
	}

	if key_slap2 or keyboard_check_pressed(vk_f5) or key_start
	{
		scr_soundeffect(sfx_enemyprojectile);
		open = false;
	}
}

