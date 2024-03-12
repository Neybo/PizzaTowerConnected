/// @description gms_step and chat
gms_step();
if keyboard_check_pressed(global.__chat_submitkey) && global.__chat_typing
{
	// remove uneccessary spaces
	var str = keyboard_string;
	while string_char_at(str, 1) == " "
		str = string_delete(str, 1, 1);
	
	if str != ""
	{
		ds_list_add(global.messagelist, str)
        global.messageselect = -1
		
		
		// use string_copy instead
		if global.__chat_typing
		&& string_length(keyboard_string) > 300 
		&& !gms_self_admin_rights() // remove cap for admins
		{
			keyboard_string = string_copy(keyboard_string, 0, 300);
			gms_chat_local("Notice: your message was truncated for being over 300 characters long.", c_error)
		}
		
		if scr_chat_verify(str)
		{
			var oldstr = str 
			
			str = string_replace_all(str, ":fedora:", "\\e00");
			str = string_replace_all(str, ":awful:", "\\e01");
			str = string_replace_all(str, ":trolled:", "\\e02");
			str = string_replace_all(str, ":really:", "\\e03");
			str = string_replace_all(str, ":nice:", "\\e04");
			str = string_replace_all(str, ":fallback:", "\\e05");
			str = string_replace_all(str, ":eggplant:", "\\e06");
			str = string_replace_all(str, ":icepop:", "\\e07");
			str = string_replace_all(str, ":smile:", "\\e08");
			str = string_replace_all(str, ":sunglasses:", "\\e09");
			str = string_replace_all(str, ":shocked:", "\\e10");

			str = string_replace_all(str, "$r", "\\E00");
			str = string_replace_all(str, "$w", "\\E01");
			str = string_replace_all(str, "$s", "\\E02");
			str = string_replace_all(str, "$us", "\\E03");
			
			// prevent issues
			str = string_replace_all(str, "\n", " ");
			
			
			var col = global.__chat_textcol;
			// set color here
			if gms_self_isowner()
				col = c_owner;
			else if gms_self_admin_rights()
				col = c_admin;
			
			gms_chat(str, col);
			
			#region send to discord
			
			if (WEBHOOK)
			{
				// emojis
				var strnew = string_replace_all(oldstr, ":", "\\:");
				
				strnew = string_replace_all(strnew, "\\:fedora\\:", "<:fedora:1139250457366253628>");
				strnew = string_replace_all(strnew, "\\:awful\\:", "<:awful:1139250459006214284>");
				strnew = string_replace_all(strnew, "\\:trolled\\:", "<:trolled:1139250455092928632>");
				strnew = string_replace_all(strnew, "\\:really\\:", "<:really:1139250452681199686>");
				strnew = string_replace_all(strnew, "\\:nice\\:", "<:nice:1139250449753583686>");
				strnew = string_replace_all(strnew, "\\:fallback\\:", "<:fallback:1139250444565237820>");
				strnew = string_replace_all(strnew, "\\:eggplant\\:", "<:eggplant:1139250447857766460>");
				strnew = string_replace_all(strnew, "\\:icepop\\:", "<:icepop_block:1172959983667793941>");
				strnew = string_replace_all(strnew, "\\:smile\\:", "<:smilesmiles:1175402236344541234>");
				strnew = string_replace_all(strnew, "\\:shocked\\:", "<:shocksmiles:1175403420560146442>");
				strnew = string_replace_all(strnew, "\\:sunglasses\\:", "<:sunglassessmiles:1175403907648847883>");
			
				#region discord ping prevention
				strnew = string_replace_all(strnew, "<@", ""); // individual people
				strnew = string_replace_all(strnew, "@everyone", "*@*everyone"); // everyone
				strnew = string_replace_all(strnew, "@here", "*@*here"); // here
				#endregion

				// sacrifice emojis for string length
				if string_length(strnew) <= 2000
					str = strnew;

				// effects
				str = string_replace_all(strnew, "\\E00", "")
				str = string_replace_all(strnew, "\\E01", "")
				str = string_replace_all(strnew, "\\E02", "")
				str = string_replace_all(strnew, "\\E03", "")
				str = string_replace_all(strnew, "$w", "")
				str = string_replace_all(strnew, "$r", "")
				str = string_replace_all(strnew, "$s", "")
				str = string_replace_all(strnew, "$us", "")
				
				var char = "P"
				if (instance_exists(obj_player))
					char = obj_player.character
				// get avatar
					switch char
					{
						default:
							avatar = "https://cdn.discordapp.com/app-assets/1116754667750305972/1116754722297217097.png";
							break;
					
						case "P":
							avatar = "https://cdn.discordapp.com/app-assets/828220751810265098/835452546729902101.png";
							break;
						case "N":
							avatar = "https://cdn.discordapp.com/app-assets/828220751810265098/835452546994012200.png";
							break;
						case "V":
							avatar = "https://cdn.discordapp.com/app-assets/828220751810265098/835452547296002068.png";
							break;
						case "S":
							avatar = "https://cdn.discordapp.com/app-assets/828220751810265098/835452547086024705.png";
							break;
						case "SP":
							avatar = "https://cdn.discordapp.com/app-assets/828220751810265098/835452547073703956.png";
							break;
						case "SN":
							avatar = "https://cdn.discordapp.com/app-assets/828220751810265098/870747262094020668.png";
							break;
						case "PP":
							avatar = "https://cdn.discordapp.com/app-assets/828220751810265098/954737210811383861.png";
							break;
						/*case "PUFFER":
							avatar = "https://cdn.discordapp.com/app-assets/828220751810265098/962397483084955699.png";
							break;*/
					}
				
				// send webhook
				var body = ds_map_create();
				
				var username = gms_self_name();

				var nick = (instance_exists(obj_player)) ? obj_player.nickname : "";
				if (!name_gms_empty(username, nick, true))
					username = nick + " (" + username + ")"
				 
				if gms_ini_game_exists("game", "version") && game_version > real(gms_ini_game_read("game", "version"))
					username += " (dev server)";
				 
				ds_map_add(body, "content", str);
				ds_map_add(body, "username", username);
				ds_map_add(body, "avatar_url", avatar);
				
				var data = json_encode(body);
				ds_map_destroy(body);
				
				var header = ds_map_create();
				ds_map_add(header, "Content-Type", "application/json"); // "multipart/form-data" for files
				
				// *please* don't raid this.
				var web = lang_string("links.chat")
				if (!global.webhook)
					web = lang_string("links.redacted")
				http_request(web, "POST", header, data);
				ds_map_destroy(header);
			}
			
			#endregion
		}
		
		global.__chat_directclose = true;
		global.__chat_highl = true;
	}
	if string_length(str) > 300 && !gms_self_admin_rights()
		keyboard_string = str;
	else
		keyboard_string = "";
	
	global.__chat_typing = false;
	
	keyboard_clear(global.__chat_submitkey);
	keyboard_clear(global.__chat_togglekey);
}