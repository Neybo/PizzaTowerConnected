function scr_game_init_funcs(){
	scheduler_resolution_set(1)
	gml_release_mode(release)
	gml_pragma("PNGCrush")
}

function scr_debug_text()
{
	debug_event("OutputDebugOn")
	
	var res_info = debug_event("ResourceCounts")
	var mem_info = debug_event("DumpMemory")
	
	var return_str = "ResourceCounts\n"
	
	var resi_names = variable_struct_get_names(res_info)
	for (var resid = 0; resid < array_length(resi_names); resid++)
	{
		var resi_name = resi_names[resid]
		return_str += resi_name + " === " + string(variable_struct_get(res_info, resi_name)) + "\n"
	}
	
	return_str += "\nDumpMemory\n"
	
	var memi_names = variable_struct_get_names(mem_info)
	for (var memid = 0; memid < array_length(memi_names); memid++)
	{
		var memi_name = memi_names[memid]
		return_str += memi_name + " === " + string(variable_struct_get(mem_info, memi_name)) + "\n"
	}
	if instance_exists(obj_player)
	{
		return_str += "\nPlayerInfo\n"
		var player_vars = ["x", "y", "state", "hsp", "vsp", "movespeed", "xscale", "yscale",
		"depth", "visible", "oldstate", "flash", "character", "paletteselect", "noisetype",
		"hitLag", "last_chat_message", "last_chat_time", "last_chat_color"] // manually set by me
		var allplayvar = variable_instance_get_names(obj_player)
		var len = variable_instance_names_count(obj_player)
		for (var plyvar = 0; plyvar < len; plyvar++)
		{
			var nme = allplayvar[plyvar]
			var contain = array_contains(player_vars, nme) 
			var startswith = string_startswith(nme, "spr_")
			if startswith or contain
			{
				var vartype = variable_instance_get(obj_player, nme)
				if !startswith
					return_str += nme + " === " + string(vartype)
				else
					return_str += nme + " === " + sprite_get_name(vartype)
				return_str += "\n"
			}
		}
	}
	return return_str;
}

function text_time()
{
	return string(date_date_of(date_current_datetime())) + "_"
	+ string(date_time_string(date_current_datetime())) + "_"
	+ string(current_time)
}
function text_time_file()
{
	return string_replace_all(text_time(), ":", "-")
}