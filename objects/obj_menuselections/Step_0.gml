if instance_exists(obj_keyconfig)
visible = false
else
visible =true



//Controls
ini_open("saveData.ini");
global.key_up = ini_read_string("ControlsKeys","up",vk_up)
global.key_right = ini_read_string("ControlsKeys","right",vk_right)
global.key_left = ini_read_string("ControlsKeys","left",vk_left)
global.key_down = ini_read_string("ControlsKeys","down",vk_down)
global.key_jump = ini_read_string("ControlsKeys","jump",ord("Z"))
global.key_slap = ini_read_string("ControlsKeys","slap",ord("X"))
global.key_shoot = ini_read_string("ControlsKeys","shoot",ord("C"))
global.key_attack = ini_read_string("ControlsKeys","attack",vk_shift)
global.key_start = vk_escape 


global.key_upC = ini_read_string("ControllerButton","up",gp_padu)
global.key_rightC = ini_read_string("ControllerButton","right",gp_padr)
global.key_leftC = ini_read_string("ControllerButton","left",gp_padl)
global.key_downC = ini_read_string("ControllerButton","down",gp_padd)
global.key_jumpC = ini_read_string("ControllerButton","jump",gp_face1)
global.key_slapC = ini_read_string("ControllerButton","slap",gp_face3)
global.key_shootC = ini_read_string("ControllerButton","shoot",gp_face2)
global.key_attackC = ini_read_string("ControllerButton","attack",gp_shoulderr)
global.key_startC = gp_start


ini_close();

if levelselect = true
{
	
	if !instance_exists(obj_keyconfig)
		scr_getinput()
	//Select
	if key_down2 && b < 5
		b += 1
	if key_up2 && b > 0
		b -= 1

	//Confirm
	if  !instance_exists(obj_fadeout)
	{
		if key_jump
		{
	
			with instance_create(x,y,obj_fadeout)
			{
				if other.b = 0
				{
					obj_player.targetRoom = floor1_room0
					obj_player.player_x = 192 + 16
					obj_player.player_y = 480 - 46
					obj_player.character = "P"
				}
	
				if other.b = 1
				{
					obj_player.targetRoom = oldmansion_0
					obj_player.player_x = 192 + 16
					obj_player.player_y = 480 - 46 	
					obj_player.character = "P"
				}
	
				if other.b = 2
				{
					obj_player.targetRoom = oldfactory_0
					obj_player.player_x = 960 + 16
					obj_player.player_y = 480 - 46	
					obj_player.character = "P"
				}
	
				if other.b = 3
				{
					obj_player.targetRoom = oldsewer_0
					obj_player.player_x = 288 + 16
					obj_player.player_y = 448 - 46
					obj_player.character = "P"
				}
				if other.b = 4
				{
					obj_player.targetRoom = oldfreezer_1
					obj_player.player_x = 228 + 16
					obj_player.player_y = 233 - 46
					obj_player.character = "P"
					
				}
								if other.b = 5
				{
					obj_player.targetRoom = golf_1
					obj_player.player_x = 160 + 16
					obj_player.player_y = 448 - 46
					obj_player.character = "P"
					
				}
			}
			
	}
						if key_slap2
		{
	
			with instance_create(x,y,obj_fadeout)
			{
				if other.b = 0
				{
					//obj_player.targetRoom = floor1_roomtreasure
					obj_player.player_x = 250
					obj_player.player_y = 250
					obj_player.character = "P"
				}
	
				if other.b = 1
				{
					obj_player.targetRoom = oldmansion_treasure
					obj_player.player_x = 250
					obj_player.player_y = 250
					obj_player.character = "P"
				}
	
			}
		}
}
}
else if levelselect = false
{
	if !instance_exists(obj_keyconfig)
		scr_getinput()
	
	if key_up && !instance_exists(obj_keyconfig) && optionselect = 1
	{
		optionselect = 0
		//scr_sound(sound_points)
	}
	else if key_down && !instance_exists(obj_keyconfig) && optionselect = 0
	{
		optionselect = 1
//		scr_sound(sound_points)
	}
	if optionselect = 0
	{
		obj_cursor.y = y - 24
	}
	else if optionselect = 1
	{
		obj_cursor.y = y + 18
	}

	if optionselect = 0 && key_jump && !instance_exists(obj_keyconfig)
	{
		//obj_rockcutscene.hspeed = -15
		//scr_sound(sound_pizzagot)
		//instance_destroy()
		//instance_destroy(obj_cursor)
		//instance_destroy(obj_title)
		levelselect = true
		sprite_index = spr_null
	}

	if optionselect = 1 && !instance_exists(obj_keyconfig)
	{
		if keyboard_check_pressed(global.key_jump)
		{
		//scr_sound(sound_pizzagot)
		instance_create(x,y,obj_keyconfig)
		}
		else if gamepad_button_check_pressed(0, global.key_jumpC)
		{
		//scr_sound(sound_pizzagot)
		with instance_create(x,y,obj_keyconfig)
		controller = true
		}
	}
}


	
