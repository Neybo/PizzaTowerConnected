function scr_initinput()
{
	ini_open("saveData.ini");

	global.key_up = ini_read_real("ControlsKeys","up",vk_up)  
	global.key_right = ini_read_real("ControlsKeys","right",vk_right)
	global.key_left = ini_read_real("ControlsKeys","left",vk_left)
	global.key_down = ini_read_real("ControlsKeys","down",vk_down)
	global.key_jump = ini_read_real("ControlsKeys","jump",ord("Z"))
	global.key_slap = ini_read_real("ControlsKeys","slap",ord("X"))
	global.key_taunt = ini_read_real("ControlsKeys","taunt",ord("C"))
	global.key_shoot = ini_read_real("ControlsKeys","shoot",ord("A"))
	global.key_attack = ini_read_real("ControlsKeys","attack",vk_shift)
	global.key_chainsaw	= ini_read_real("ControlsKeys", "chainsaw", ord("S"))
	global.key_extra = ini_read_real("ControlsKeys", "extra", ord("V"))
	global.key_start = ini_read_real("ControlsKeys","start", vk_escape)
	
	global.key_upC = ini_read_real("ControllerButton", "up", gp_padu)
	global.key_rightC = ini_read_real("ControllerButton","right",gp_padr)
	global.key_leftC = ini_read_real("ControllerButton","left",gp_padl)
	global.key_downC = ini_read_real("ControllerButton","down",gp_padd)
	global.key_jumpC = ini_read_real("ControllerButton","jump",gp_face1)
	global.key_slapC = ini_read_real("ControllerButton","slap",gp_face3)
	global.key_tauntC = ini_read_real("ControllerButton","taunt",gp_face4)
	global.key_shootC = ini_read_real("ControllerButton","shoot",gp_face2)
	global.key_attackC = ini_read_real("ControllerButton","attack",gp_shoulderrb)
	global.key_chainsawC = ini_read_real("ControllerButton", "chainsaw", gp_shoulderr)
	global.key_extraC = ini_read_real("ControllerButton", "extra", gp_shoulderlb)
	global.key_startC = ini_read_real("ControllerButton","start",gp_start)

	ini_close();
}

function scr_resetinput()
{
	ini_open("saveData.ini");

	ini_write_real("ControlsKeys","up",vk_up)  
	ini_write_real("ControlsKeys","right",vk_right)
	ini_write_real("ControlsKeys","left",vk_left)
	ini_write_real("ControlsKeys","down",vk_down)
	ini_write_real("ControlsKeys","jump",ord("Z"))
	ini_write_real("ControlsKeys","slap",ord("X"))
	ini_write_real("ControlsKeys","taunt",ord("C"))
	ini_write_real("ControlsKeys","shoot",ord("A"))
	ini_write_real("ControlsKeys","attack",vk_shift)
	ini_write_real("ControlsKeys", "chainsaw", ord("S"))
	ini_write_real("ControlsKeys", "extra", ord("V"))
	ini_write_real("ControlsKeys","start", vk_escape)
		
	ini_write_real("ControllerButton", "up", gp_padu)
	ini_write_real("ControllerButton","right",gp_padr)
	ini_write_real("ControllerButton","left",gp_padl)
	ini_write_real("ControllerButton","down",gp_padd)
	ini_write_real("ControllerButton","jump",gp_face1)
	ini_write_real("ControllerButton","slap",gp_face3)
	ini_write_real("ControllerButton","taunt",gp_face4)
	ini_write_real("ControllerButton","shoot",gp_face2)
	ini_write_real("ControllerButton","attack",gp_shoulderrb)
	ini_write_real("ControllerButton", "chainsaw", gp_shoulderr)
	ini_write_real("ControllerButton", "extra", gp_shoulderlb)
	ini_write_real("ControllerButton","start",gp_start)

	ini_close();
}