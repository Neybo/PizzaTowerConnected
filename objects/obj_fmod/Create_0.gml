show_debug_message(fmod_error_string(fmod_init(32)))
fmodgms_set_debug(debug)

// link to fmod studio to compile yourself: https://www.mediafire.com/file/8bs9i1tbgow0sbs/fmodstudio20213win64-installer.exe/file

var banks = ["Master.bank", "Master.strings.bank", "music.bank", "sfx.bank"]

var loaded_banks = 0
var preloaded_banks = 0
for (var i = 0; i < array_length(banks); i++)
{
	var ret = fmod_load_bank("sound/Desktop/" + banks[i])
	if ret != FMOD_RESULT.FMOD_OK 
		show_message("Error while loading " + banks[i] + "!\nError:\n" + fmod_error_string(ret))
	else 
	{
		loaded_banks++
	}
}

if loaded_banks == 0
{
	if !show_question("Error, no banks were loaded/preloaded.\nThe game will be silent and could have issues, do you wish to continue on with the game?")
	{
		game_end()
		exit;
	}
	fmodgms_set_debug(false)
	instance_destroy();
}

fmod_set_listener_amount(1)
fmod_set_listener_weight(0, 1)
fmod_set_param_master_immediately("master_vol", global.mastervolume * 0.75);