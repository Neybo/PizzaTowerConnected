// language
function lang_string(str)
{
	var ret = global.langmap[? str];
	if is_undefined(ret)
		ret = str;
	
	return ret;
}

function lang_exists(txt)
{
	return ds_map_exists(global.langmap, txt)
}

function lang_str(str)
{
	return lang_string(str) // hah!
}

function lang_str_upper(str)
{
	return string_upper(lang_string(str)) // hah!
}

function lang_str_lower(str)
{
	return string_lower(lang_string(str)) // hah!
}


function lang_sprite(spr)
{
	var ret = global.langspr[? spr];
	if is_undefined(ret)
		ret = spr;
	
	return ret;
}

function lang_load(lang = undefined)
{
	if lang == undefined
		lang = get_specific_lang()
	
	global.langmap = ds_map_create();
	global.langspr = ds_map_create();
	
	#region custom langs setup
		global.langs = [];
	
		var f = file_text_open_read("lang/global.txt")
		while (!file_text_eof(f))
		{
			var text = file_text_readln(f)
			var langinfo = string_split_array(text, ";")
			array_push(global.langs, 
			create_lang_opt(langinfo[1], langinfo[0], string_split_array(langinfo[2], ","),
			langinfo[3], langinfo[4], langinfo[5]))
		}
		file_text_close(f)
	#endregion
	
	#region PARSER
		show_debug_message("lang/" + lang + ".txt")
		if !file_exists("lang/" + lang + ".txt")
			lang = "en" // back-up for now
		var f = file_text_open_read("lang/" + lang + ".txt")
		while (!file_text_eof(f))
		{
			var text = file_text_readln(f)
			//text = ""
			if string_startswith(text, "#") || text == ""
			|| string_startswith(text, "\n")
			{
				continue;
			}
			var pos = string_pos("=", text)
			// trim off \n's bitch!
			var trimoff = -1
			if string_ord_at(text, string_length(text)) == 127 
			|| string_ord_at(text, string_length(text)) == ord("\n")
				trimoff++
			if string_ord_at(text, string_length(text)) == 127 
			|| string_ord_at(text, string_length(text)) == ord("\n")
				trimoff++
				
			var newtext = string_copy(text, pos + 1, string_length(text) - pos - trimoff)
			ds_map_add(global.langmap, string_copy(text, 1, pos - 1), 
			string_replace_all(string_replace_all(newtext, "\\n", "\n"), "\\\"", "\""))
		}
		file_text_close(f)
	#endregion
	
	if ds_map_empty(global.langmap)
		show_message("Language \"" + string(lang) + "\" failed to load!!");
}

function create_lang_opt(langfile, langname, langcredits, langdefault, langdone, langreset)
{
	return {
		file: langfile,
		name: langname,
		credits: langcredits,
		text_default: langdefault,
		text_done: langdone,
		text_reset: langreset,
	}
}