#macro CPP_USED scr_cpp_check()
#macro RPC_USED scr_rpc_check()

function scr_rpc_check(){
	return os_type == os_windows
}

function scr_cpp_check(){
	return os_type == os_windows
}
 
function get_specific_lang()
{
	var retlang = string_lower(os_get_language())
	var reg = string_lower(os_get_region())
	switch retlang
	{
		case "-":
			retlang = "en" // fallback!
			break;
		case "es":
			if reg == "ar"
				retlang = "es-ar"
			break;
	}
	return retlang
}