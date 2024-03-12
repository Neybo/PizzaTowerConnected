key_select = 0
selecting = -1
savekey = -1

keys = optionrc_create(
	["key_up","key_down","key_left","key_right","key_jump", "key_slap", "key_attack", "key_taunt", 
	"key_shoot", "key_chainsaw", "key_start", "key_extra"],
	["UP", "DOWN", "LEFT", "RIGHT", "JUMP", "ATTACK", "MACH", "TAUNT", 
	(global.breakdance) ? "BREAKDANCE" : "SHOOT", "CHAINSAW",
	"PAUSE", "EXTRA"], [vk_f1,vk_f2,vk_f3,vk_f4,vk_f5,vk_f6,vk_f7,vk_f8,vk_f9,vk_f10,vk_f11,vk_f12,
	vk_numpad0, vk_numpad1, vk_numpad3, vk_numpad4, vk_numpad5, vk_numpad6, vk_numpad7, vk_numpad8,
	vk_numpad9]
);

depth  = -99


function do_i_nuh_uh()
{
	var backup = []
	array_copy(backup, 0, keys.controls, 0, array_length(keys.controls))
	var flyfkcking = []
	array_copy(flyfkcking, 0, keys.controls, 0, array_length(keys.controls))

	var banned_keys = keys.blacklist

	array_delete(flyfkcking, selecting, 1)
	
	for (var i = 0; i < array_length(banned_keys); i++)
	{
		if banned_keys[i] == keyboard_key
			return true;
	}
	
	for (var i = 0; i < array_length(flyfkcking); i++)
	{
		var key = variable_global_get(flyfkcking[i])
		if key == keyboard_key
		{
			variable_global_set(backup[selecting], savekey)
			return true
		}
	}
	return false
}