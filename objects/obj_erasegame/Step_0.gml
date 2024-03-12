//Move Up and down
if !instance_exists(obj_keyconfig)
{
	if (-obj_player.key_left2 or keyboard_check_pressed(vk_left)) && optionselected > 0 
	{
		optionselected -= 1
		scr_soundeffect(sfx_step)
	}
	if (obj_player.key_right2 or keyboard_check_pressed(vk_right)) && optionselected < 1
	{
		optionselected += 1
		scr_soundeffect(sfx_step)
	}
}
//Full Screen
if optionselected == 1 && (obj_player.key_jump or keyboard_check_pressed(vk_enter))
{
	file_delete("saveData.ini")
	file_delete("saveData1.ini")
	file_delete("saveData2.ini")
	file_delete("saveData3.ini")
	
	fmod_destroy();
	scr_soundeffect(sfx_breakblock);
	game_restart();
}

//Finish
if (obj_player.key_slap2 or keyboard_check_pressed(vk_escape)) 
or (optionselected = 0  && (obj_player.key_jump or keyboard_check_pressed(vk_enter))) 
{
	scr_soundeffect(sfx_enemyprojectile)
	obj_option.visible = true
	fmod_set_vol(global.music, global.musicvolume, true)
	instance_destroy()
}