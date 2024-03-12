#region scr_getuser

function scr_getuser(argument0, argument1 = false)
{
	var __uservar = ds_list_find_value(argument0, 1);
	var __uservar2 = false;
	var not_found = string_replace(lang_str("online.notfound"), "{NAME}", __uservar)

	if string_isnumber(__uservar)
	{
		if gms_other_find(real(__uservar)) != -1
			__uservar2 = gms_other_find(real(__uservar));
		else
		{
			if !argument1
				gms_chat_local(not_found, c_error);
			return false;
		}
	}
	else if gms_other_find_by_name(__uservar) == -1
	{
		if !argument1
			gms_chat_local(not_found, c_error);
		return false;
	}
	else
		__uservar2 = gms_other_find_by_name(__uservar);
	return __uservar2;
}

#endregion
function scr_chat_verify(argument0, argument1 = gms_self_admin_rights() > 0)
{
	var list = string_split(argument0, " ");
	var superad = gms_self_isowner()
	// this took a little but its worth it -reycko
	switch list[| 0] {
	#region /list
	case "/list":
		if gms_other_count() <= 0
		{
			var choice = irandom(21) + 1
			if choice == 7 && obj_player.character == "S"
				choice++
			else if choice == 8 && obj_player.character != "s"
				choice--;
			gms_chat_local(lang_str("online.nooneelse." + string(choice)), 
			c_success);
		}
		else
		{
			if gms_other_count() == 1
				var str = lang_str("online.otherperson") + (global.streamer ? "" : ":");
			else
				str = string_replace_all(lang_str("online.otherpeople"), "{USERS}", string(gms_other_count())) 
				+ (global.streamer ? "" : ":");
			
			if !global.streamer
			{
				gms_chat_local(str, c_success);
			
				var __str = "";
				for(var i = 0; i < gms_other_count(); i++)
					__str += (i != 0 ? ", " : "") + gms_other_get_string(gms_other_find(i), "name");
				gms_chat_local(__str, c_success);
			}
		}
		return false;
	break;
	
	#endregion
	#region /t (minichat)
	
	case "/t":
	case "/minichat":
		ini_open("saveData.ini")
		global.minichat = !global.minichat;
		ini_write_real("online", "minichat", global.minichat)
		ini_close()
		gms_chat_local(lang_str("online.toggleminichat") + " " + (global.minichat ? lang_str("options.on") : lang_str("options.off")), c_success);
		return false;
	break;
	
	#endregion
	#region /ping
	case "/ping":
		gms_chat_local(lang_str("online.returnedms") + " " + string(gms_info_ping()) + "ms", c_success);
		return false;
	break;
	
	#endregion
	
	// admin
	#region /tphere
	
	case "/tphere":
		if argument1
		{
			list = string_split(argument0, " ");
			if ds_list_size(list) != 2
			{
				gms_chat_local(lang_str("online.usage") + ": /tphere " + lang_str("online.name"), c_error);
				return false;
			}
		
			var __uservar = ds_list_find_value(list, 1);
			if string_lower(__uservar) == "all" && gms_self_admin_rights()
			{
				gms_p2p_send(p2p.tpother, 0, obj_player.x, obj_player.y, scr_gms_room());
				gms_chat_local("Pulling everyone", c_success);
				return false;
			}
			else
			{
				__user = scr_getuser(list);
				if __user == false
					return false;
				
				// do the thing
				gms_p2p_send(p2p.tpother, __user, obj_player.x, obj_player.y, scr_gms_room());
				gms_chat_local("Pulling " + gms_other_get_string(__user, "name"), c_success);
				
				return false;
			}
		}
	break;
	
	#endregion
	#region /tp
	
	case "/tp":
		if argument1 // tp admin
		{
			list = string_split(argument0, " ");
			if ds_list_size(list) != 2
			{
				gms_chat_local(lang_str("online.usage") + ": /tp " + lang_str("online.name"), c_error);
				return false;
			}
			
			__user = scr_getuser(list);
			if __user == false
				return false;
			
			// do the thing
			scr_playerreset();
			obj_player.targetDoor = "none";
			obj_player.state = -1;
		
			var _room = gms_other_get_real(__user, "room");
			if room != _room
				room_goto_new(_room);
				
			var newx = gms_other_get_real(__user, "x");
			var newy = gms_other_get_real(__user, "y");
			
			with obj_player
			{
				x = newx
				y = newy
			}
			
			gms_chat_local("Teleporting to player " + ds_list_find_value(list, 1) + " in room " + room_get_name(gms_other_get_real(__user, "room")), c_success);
			obj_gms.alarm[0] = 5;
			return false;
		}
		else // tp request
		{
			list = string_split(argument0, " ");
			if ds_list_size(list) != 2
			{
				gms_chat_local(lang_str("online.usage") + ": /tp " + lang_str("online.name"), c_error);
				return false;
			}
			
			__user = scr_getuser(list);
			if __user == false
				return false;
			
			gms_p2p_send(p2p.tpreq, __user, p2ptpreq.sent)

			gms_chat_local(string_replace(lang_str("online.tp.sentout"), 
			"{USER}", ds_list_find_value(list, 1)), c_success);
			return false;
		}
	break;
	
	#endregion
	#region teleport request shit
	
	#region tpyes
	case "/tpyes": // accept
		if global.tprequserid == -1
		{
			gms_chat_local(lang_str("online.tp.whoaccept"), c_pvp)
			return false;
		}
		var allplayers = gms_other_count()
		var found = false
        for (i = 0; i < allplayers; i++)
	    {
			if (gms_other_get_string(global.tprequserid, "name") == global.tprequsername)
			{
				found = true
				break;
			}
        }
		global.tprequserid = -1
		global.tprequsername = lang_str("online.thisisbug")
		if !found
		{
			gms_chat_local(global.tprequsername + " " + lang_str("online.tp.acceptleft"), c_pvp)
			return false;
		}
		gms_p2p_send(p2p.tpreq, global.tprequserid, p2ptpreq.accept)
		gms_chat_local("You accepted " + global.tprequsername + "'s TP request!", c_admin)	
		return false;
	break;
	#endregion
	#region tpno
	case "/tpno": // decline
		if global.tprequserid == -1
		{
			gms_chat_local("Whose request are you declining?", c_pvp)
			return false;
		}
		var allplayers = gms_other_count()
		var found = false
        for (i = 0; i < allplayers; i++)
	    {
			if (gms_other_get_string(global.tprequserid, "name") == global.tprequsername)
			{
				found = true
				break;
			}
        }
		if !found
		{
			gms_chat_local(global.tprequsername + " has left the game, so it's all fine.", c_pvp)
			global.tprequserid = -1
			global.tprequsername = lang_str("online.thisisbug")
			return false;
		}
		gms_p2p_send(p2p.tpreq, global.tprequserid, p2ptpreq.decline)
		gms_chat_local("You declined " + global.tprequsername + "'s TP request!", c_admin)
		global.tprequserid = -1
		global.tprequsername = lang_str("online.thisisbug")
		return false;
	break;
	#endregion
	#region tpwho
	case "/tpwho": // who are you accepting?
		if global.tprequserid == -1
		{
			gms_chat_local("What request?", c_pvp)
			return false;
		}
		var allplayers = gms_other_count()
		var found = false
        for (i = 0; i < allplayers; i++)
	    {
			if (gms_other_get_string(global.tprequserid, "name") == global.tprequsername)
			{
				found = true
				break;
			}
        }
		if !found
		{
			gms_chat_local(global.tprequsername + " sent you a request but they left so...", c_pvp)
			global.tprequserid = -1
			global.tprequsername = lang_str("online.thisisbug")
			return false;
		}
		gms_chat_local("The current request was sent by " + global.tprequsername, c_admin)
		return false;
	break;
	#endregion
	
	#endregion
	#region /global
	
	case "/global":
	case "/g":
		if argument1
		{
			list = string_split(argument0, " ");
			if ds_list_size(list) < 2
			{
				gms_chat_local(lang_str("online.usage") + ": /global MESSAGE", c_error);
				return false;
			}
			gms_global_set("gotmessage", string_replace(argument0, ds_list_find_value(list, 0) + " ", ""));
			
			/*
			var allplayers = gms_other_count();
			var i = 0;
			while i < allplayers
			{
				gms_p2p_send(p2p.globalmessage, gms_other_find(i));
				allplayers = gms_other_count();
				i++;
			}
			*/
			
			gms_p2p_send(p2p.globalmessage, -1);
			
			/*
			obj_gms.__author = gms_self_name();
			global.__gotmessage = [true, string_replace(argument0, ds_list_find_value(list, 0) + " ", ""), obj_gms.__author];
			*/
			jba_global(gms_self_name() + " has an announcement!", 
			string_replace(argument0, ds_list_find_value(list, 0) + " ", ""), globalembeds.global)
			
			return false;
		}
	break;
	
	case "/silentglobal":
	case "/sg":
		if superad
		{
			list = string_split(argument0, " ");
			if ds_list_size(list) < 2
			{
				gms_chat_local(lang_str("online.usage") + ": /global MESSAGE", c_error);
				return false;
			}
			gms_global_set("gotmessage", string_replace(argument0, ds_list_find_value(list, 0) + " ", ""));
			
			/*
			var allplayers = gms_other_count();
			var i = 0;
			while i < allplayers
			{
				gms_p2p_send(p2p.globalmessage, gms_other_find(i));
				allplayers = gms_other_count();
				i++;
			}
			*/
			
			gms_p2p_send(p2p.globalmessage, -1);
			
			/*
			obj_gms.__author = gms_self_name();
			global.__gotmessage = [true, string_replace(argument0, ds_list_find_value(list, 0) + " ", ""), obj_gms.__author];
			*/
			
			return false;
		}
	break;
	
	#endregion
	#region /tp pos & room
	
	/*
	else if string_startswith(argument0, "/tpos ")
	{
		if gms_self_admin_rights() or debug
		{
			list = string_split(argument0, " ");
			
			if ds_list_size(list) != 3
			or !string_isnumber(list[| 1]) or !string_isnumber(list[| 2])
			{
				gms_chat_local(lang_str("online.usage") + ": /tp X Y", c_error);
				return false;
			}
			
			with 
			{
				x = real(list[| 1]);
				y = real(list[| 2]);
			}
			return false;
		}
	}
	
	else if string_startswith(argument0, "/tproom ")
	{
		if gms_self_isowner() or debug
		{
			list = string_split(argument0, " ");
			
			if ds_list_size(list) != 2
			{
				gms_chat_local(lang_str("online.usage") + ": /tp ROOM", c_error);
				return false;
			}
			
			var foundroom = false;
			if string_isnumber(list[| 1])
			{
				if room_exists(real(list[| 1]))
				{
					room_goto(real(list[| 1]));
					foundroom = true;
				}
			}
			else if asset_get_type(list[| 1]) == asset_room
			{
				room_goto(asset_get_index(list[| 1]));
				foundroom = true;
			}
			
			if !foundroom
				gms_chat_local("Room " + string(list[| 1]) + " not found", c_error);
			else with 
				targetDoor = "A";
			return false;
		}
	}
	*/
	
	#endregion
	
	// owner
	#region /kick
	
	case "/kickall":
		if gms_self_admin_rights() or debug
		{
			for(var i = 0; i < gms_other_count(); i++)
				gms_admin_kick(gms_other_find(i), "kicked by kickall");
			
			gms_chat_local("Kicked everyone", c_success);
			return false;
		}
	break;
	
	#endregion
	#region /setvar
	
	case "/setvar":
		if argument1
		{
			list = string_split(argument0, " ");
			if ds_list_size(list) < 4
			{
				gms_chat_local(lang_str("online.usage") + ": /setvar PLAYER VARIABLE VALUE", c_error);
				return false;
			}
		
			var setto = ds_list_find_value(list, 3);
			if (ds_list_size(list) > 4)
				{
					for (i = 3; i < ds_list_size(list); i++)
					{
						setto += ds_list_find_value(list, i)
						if (i < (ds_list_size(list) - 1))
							setto += " "
					}
				}
			else
				setto = ds_list_find_value(list, 3)
			
			
			if string_isnumber(setto)
				setto = real(setto);
			else if asset_get_index(setto) != -1
				setto = asset_get_index(setto);
			else
				setto = string_replace(setto, @"\", "");
		
			if string_lower(ds_list_find_value(list, 1)) == "all"
			{
				gms_p2p_send(p2p.setvar, -1, ds_list_find_value(list, 2), setto);
				gms_chat_local("Setting variable " + ds_list_find_value(list, 2) + " to " + string(setto) + " in everyone", c_success);
			}
			else
			{
				__user = scr_getuser(list);
				if __user == false
					return false;
		
				gms_p2p_send(p2p.setvar, __user, ds_list_find_value(list, 2), setto);
				gms_chat_local("Setting variable " + ds_list_find_value(list, 2) + " to " + string(setto) + " in player " + gms_other_get_string(__user, "name"), c_success);
			}
			return false;
		}
	break;
	
	#endregion
	#region /globalvar
	
	case "/globalvar":
		if argument1
		{
			list = string_split(argument0, " ");
			if ds_list_size(list) != 4
			{
				gms_chat_local(lang_str("online.usage") + ": /globalvar PLAYER VARIABLE VALUE", c_error);
				return false;
			}
		
			var setto = ds_list_find_value(list, 3);
			if (ds_list_size(list) > 4)
				{
					for (i = 3; i < ds_list_size(list); i++)
					{
						setto += ds_list_find_value(list, i)
						if (i < (ds_list_size(list) - 1))
							setto += " "
					}
				}
			else
				setto = ds_list_find_value(list, 3)
				
			if string_isnumber(setto)
				setto = real(setto);
			else if asset_get_index(setto) != -1
				setto = asset_get_index(setto);
			else
				setto = string_replace(setto, @"\", "");
		
			if string_lower(ds_list_find_value(list, 1)) == "all"
			{
				gms_p2p_send(p2p.setglobal, -1, ds_list_find_value(list, 2), setto);
				gms_chat_local("Setting global variable " + ds_list_find_value(list, 2) + " to " + string(setto) + " in everyone", c_success);
			}
			else
			{
				__user = scr_getuser(list);
				if __user == false
					return false;
		
				gms_p2p_send(p2p.setglobal, __user, ds_list_find_value(list, 2), setto);
				gms_chat_local("Setting global variable " + ds_list_find_value(list, 2) + " to " + string(setto) + " in player " + gms_other_get_string(__user, "name"), c_success);
			}
			return false;
		}
	break;
	
	#endregion
	#region /nickname
	
	case "/nickname":
	case "/nick":
			list = string_split(argument0, " ");
		
			if ds_list_size(list) < 2
			{
				var nick = gms_self_name()
				.nickname = nick
				global.storenickname = nick
				gms_chat_local("Resetted nickname", c_success);
			}
			else
			{
				var nick = string_replace(argument0 + " ", ds_list_find_value(list, 0), "");
				if string_ord_at(nick, 1) != 127
				{
					nick = " " + string_trim(nick)
				}
				else
					nick = gms_self_name()
					
				if (string_length(nick) == 0) || (string_length(nick) == 3 
				&& string_ord_at(nick, 2) == 32)
					nick = gms_self_name()
				else if (string_length(nick) > 21)
					nick = string_delete(nick, 21, string_length(nick) - 21)
				.nickname = nick
				var displaynick = string_delete(nick, 1, 1)
				if (nick == gms_self_name())
					gms_chat_local("Resetted nickname", c_success);
				else
					gms_chat_local("Changed nickname to " + displaynick, c_success);
				global.storenickname = nick
			}
			return false;
	break;
	
	#endregion
	#region /music
	
	case "/music":
		if argument1
		{
			list = string_split(argument0, " ");
			if ds_list_size(list) < 3
			{
				gms_chat_local(lang_str("online.usage") + ": /music USER SOUND", c_error);
				return false;
			}
		
			var __song = "";
			if (ds_list_size(list) > 3)
				{
					for (i = 2; i < ds_list_size(list); i++)
					{
						__song += ds_list_find_value(list, i)
						if (i < (ds_list_size(list) - 1))
							__song += " "
					}
				}
			else
				__song = ds_list_find_value(list, 2)
			show_debug_message(__song)
			if !fmod_event_instance_exists(__song)
			{
				gms_chat_local("Sound " + __song + " not found", c_error);
				return false;
			}
		
			var __uservar = ds_list_find_value(list, 1);
			if string_lower(__uservar) == "all"
			{
				/*
				audio_stop_sound(global.music);
				scr_sound(__song);
				
				var allplayers = gms_other_count();
				var i = 0;
				while i < allplayers
				{
					gms_p2p_send(p2p.replacemusic, gms_other_find(i), __song);
					allplayers = gms_other_count();
					i++;
				}
				*/
				
				gms_p2p_send(p2p.replacemusic, -1, __song);
				
				gms_chat_local("Set music to " + string(__song) + " for " + "everyone", c_success);
				return false;
			}
			else
			{
				__user = scr_getuser(list);
				if __user == false
					return false;
		
				// do the thing
				gms_p2p_send(p2p.replacemusic, __user, __song);
				gms_chat_local("Set music to " + string(__song) + " for " + gms_other_get_string(__user, "name"), c_success);
				
				return false;
			}
		}
	break;


	
	#endregion
	#region /dm
	
	case "/dm":
	case "/directmessage":
		list = string_split(argument0, " ");
		if ds_list_size(list) < 3
		{
			gms_chat_local(lang_str("online.usage") + ": /dm or /directmessage USER MESSAGE", c_error);
			return false;
		}
		var msg = ""
		if (ds_list_size(list) > 3)
			{
				for (i = 2; i < ds_list_size(list); i++)
				{
					msg += ds_list_find_value(list, i)
					if (i < (ds_list_size(list) - 1))
						msg += " "
				}
			}
		else
			msg = ds_list_find_value(list, 2)
		__user = scr_getuser(list);
		if __user == false
			return false;
		gms_p2p_send(p2p.directmessage, __user, msg)
		gms_p2p_send(p2p.directmessage, gms_self_playerid(), msg, __user) // hacky fix
		return false;
	break;
	
	#endregion
	#region say from amenities
	
	case "/sudo":
	if !argument1 then break;
        list = string_split(argument0, " ")
        if (ds_list_size(list) < 3)
        {
            gms_chat_local(lang_str("online.usage") + ": /sudo USER STRING", c_error)
            return 0;
        }
		var msg = ""
		if (ds_list_size(list) > 3)
			{
				for (i = 2; i < ds_list_size(list); i++)
				{
					msg += ds_list_find_value(list, i)
					if (i < (ds_list_size(list) - 1))
						msg += " "
				}
			}
		else
			msg = ds_list_find_value(list, 2)
			
        __uservar = ds_list_find_value(list, 1)
        if (__uservar == "all")
			gms_p2p_send(p2p.sudo, -1, msg, c_white)
        else
        {
            __user = scr_getuser(list)
            if (__user == 0)
                return 0;
            gms_p2p_send(p2p.sudo, __user, msg, c_white)
        }
        return 0;
    break;
	
	#endregion
	#region object from amenities
	
	case "/object":
        if argument1
        {
            list = string_split(argument0, " ")
            if (ds_list_size(list) != 5)
            {
                gms_chat_local(lang_str("online.usage") + ": /object USER " + lang_str("online.name") + " X Y", c_error)
                return 0;
            }
            setto = ds_list_find_value(list, 2)
            xx = ds_list_find_value(list, 3)
            yy = ds_list_find_value(list, 4)
            if (asset_get_index(setto) > -1)
                setto = asset_get_index(setto)
			else
			{
				gms_chat_local("Asset not found.", c_error)
				return false
			}
            if (string_lower(ds_list_find_value(list, 1)) == "all")
            {
                allplayers = gms_other_count()
                for (i = 0; i < allplayers; i++)
                {
                    if (ds_list_find_value(list, 3) == "target")
                        xx = real(gms_other_get_real(gms_other_find(i), "x"))
                    if (ds_list_find_value(list, 4) == "target")
                        yy = real(gms_other_get_real(gms_other_find(i), "y"))
                   gms_p2p_send(p2p.instancecreate, gms_other_find(i), setto, real(xx), real(yy))
                }
                gms_chat_local((("Creating object " + ds_list_find_value(list, 2)) + " for everyone"), 
				c_success)
            }
            else
            {
                __user = scr_getuser(list)
                if (__user == 0)
                    return 0;
                if (ds_list_find_value(list, 3) == "target")
                    xx = real(gms_other_get_real(__user, "x"))
                if (ds_list_find_value(list, 4) == "target")
                    yy = real(gms_other_get_real(__user, "y"))
                gms_p2p_send(p2p.instancecreate, __user, setto, real(xx), real(yy))
                gms_chat_local(((("Creating object " + ds_list_find_value(list, 2)) + " for ") 
				+ ds_list_find_value(list, 1)), c_success)
            }
            return 0;
        }
    break;
	
	#endregion
	#region unban
	
	case "/unban":
		if (argument1)
		{
			list = string_split(argument0, " ")
			if ds_list_size(list) != 2
			{
				gms_chat_local(lang_str("online.usage") + ": /unban " + lang_str("online.name"), c_error);
				return false;
			}
			gms_admin_unban(ds_list_find_value(list, 1))
			return 0;
		}
	break;
	
	#endregion
	#region admin message
	
	case "/admsg":
		if (argument1)
		{
			list = string_split(argument0, " ")
			if ds_list_size(list) < 3
			{
				gms_chat_local(lang_str("online.usage") + ": /admsg USER MESSAGE", c_error);
				return false;
			}
			msg = ""
			if (ds_list_size(list) > 3)
			{
				for (i = 2; i < ds_list_size(list); i++)
				{
					msg += ds_list_find_value(list, i)
					if (i < (ds_list_size(list) - 1))
						msg += " "
				}
			}
			else
				msg = ds_list_find_value(list, 2)
				
			 __user = scr_getuser(list)
                if (__user == 0)
                    return 0;
			gms_p2p_send(p2p.admincrashmessage, __user, msg)
			return 0;
		}
	break;
	
	#endregion
	#region admin chat
	
	case "/ac":
		if (argument1)
		{
			list = string_split(argument0, " ")
			if ds_list_size(list) < 2
			{
				gms_chat_local(lang_str("online.usage") + ": /ac MESSAGE", c_error);
				return false;
			}
			msg = ""
			if (ds_list_size(list) > 2)
			{
				for (i = 1; i < ds_list_size(list); i++)
				{
					msg += ds_list_find_value(list, i)
					if (i < (ds_list_size(list) - 1))
						msg += " "
				}
			}
			else
				msg = ds_list_find_value(list, 1)
				
			gms_p2p_send(p2p.adminmsgs, -1, msg)
			return 0;
		}
	break;
	
	#endregion
	#region /gmsmessage

	case "/gmsmessage":
	case "/gmsmsg":
		if argument1
		{
			list = string_split(argument0, " ");
			if ds_list_size(list) < 2
			{
				gms_chat_local(lang_str("online.usage") + ": /gmsmessage OR /gmsmsg MESSAGE", c_error);
				return false;
			}     
			var msg = ""
			if (ds_list_size(list) > 2)
			{
				for (i = 1; i < ds_list_size(list); i++)
				{
					msg += ds_list_find_value(list, i)
					if (i < (ds_list_size(list) - 1))
						msg += " "
				}
			}
			else
				msg = ds_list_find_value(list, 1)
			gms_p2p_send(p2p.gmsmessagesend, gms_p2p_all_in_game, msg);
			return false;
		}
	break;

    #endregion
	#region /afk
	
	case "/afk":
		with obj_player
		{
			global.afkroom = true
			targetRoom = hub_outsideAFK
			targetDoor = choose("B", "C", "D", "E")
			instance_create(0, 0, obj_fadeout)
		}
		return 0;
	break;
	
	#endregion
	#region /built in gms
	
	case "/ban":
	case "/gms-kick":
	case "/mute":
 	case "/slowchat": 
		return true;
		break;
	
	#endregion
	
	#region easter eggs
	case "/apc":
		gms_chat_local(lang_str("online.apcsecret"), c_success)
		return false;
		break;
	#endregion
	#region invalid command or just not one
	default:
		if string_char_at(argument0, 0) == "/" 
		&& !string_contains(argument0, "/j") 
		&& !string_contains(argument0, "/hj") 
		&& !string_contains(argument0, "/srs") {
			gms_chat_local(lang_str("online.invalidcommand") + ": " + list[| 0], c_error);
			return false;
		}
		return true; // confirm sending chat message
		break; // pretty sure you dont need that because you return buttttt
	// return false to cancel sending message to others
	#endregion
	}
}