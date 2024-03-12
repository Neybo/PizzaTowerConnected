enum globalembeds {
	lap100,
	lap200,
	p_rank,
	global
}

// DONT REMOVE THE DEBUG MESSAGES I THINK THAT MAKES IT WORK hi guys im saster

function jba_global(title, msg, type)
{
		return;
	show_debug_message("announcement fired")
	var give_me_some_head_ers = ds_map_create();
	ds_map_add(give_me_some_head_ers, "user-agent", lang_string("!!!"))
	http_request("https://johnbot.kstr743.repl.co" + lang_string("links.jba.message") 
	+ "?title=" + title + "&msg=" + msg + "&type=" + string(real(type)), "GET", give_me_some_head_ers, "")
}