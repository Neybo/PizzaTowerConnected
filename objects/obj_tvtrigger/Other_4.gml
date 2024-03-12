if ds_list_find_index(global.saveroom, id) != -1 or OLD_GAMEPLAY
	instance_destroy();
if global.snickrematch && !global.snickchallenge
	instance_destroy();
ini_open("tv.ini")
if prompt_array != -4 && (ini_key_exists("ptv", string_letters(prompt_array[0][0])))
	instance_destroy()
ini_close()