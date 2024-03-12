if ds_list_find_index(global.saveroom, id) == -1 
&& !global.snickchallenge && !instance_exists(obj_randomsecret)
{
	global.secretfound += 1
	var sg = check_sugary();
	
		if !sg
		{
			var roomname = room_get_name(room);
			
			var outof = scr_secretsoutof()
		}
		
		with obj_tv
		{
			if sg
				message = "You have found a secret!";
			else
				message = "You have found " + string(global.secretfound) + " secret" + (global.secretfound == 1 ? "" : "s") + " out of " + string(outof) + "!";
			
			showtext = true
			alarm[2] = 150
		}
	
	scr_soundeffect(sg ? sfx_secretfound_ss : sfx_secretfound)
	ds_list_add(global.saveroom, id) 
}
