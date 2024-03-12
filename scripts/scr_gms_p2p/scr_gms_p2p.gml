function scr_gms_p2p(mid, sender, args)
{
	enum p2p
	{
		tpother, // x, y, room
		setvar, // variable, value
		setglobal, // variable, value
		replacemusic, // sound
		sudo, // message, color
		instancecreate, // instance, x, y
		globalmessage,
		wcdrag, // x, y
		startrace,
		
		pvp_grab,
		pvp_squish,
		pvp_punch,
		pvp_stopgrab,
		pvp_grabkickarena,
		pvp_hpspawn,
		pvp_hpkill,
		
		directmessage,
		admincrashmessage,
		adminmsgs,
		
		race_finished,
		gmsmessagesend,
		race_info,
		race_invite,
		
		tpreq, // type, user_id
	}
	enum p2ptpreq
	{
		sent,
		accept,
		decline,
		hasitblocked
	}
	var isad = gms_other_admin_rights(sender) // prevent bad actors if they get the server id
	
	var pvpdo = (gms_other_admin_rights(sender) || (!global.racing && global.pvp))
	&& (!gms_self_admin_rights() || scr_pvparenacheck()) //&& gms_other_get_real(sender, "room") == room) // prevent cheaters (will add protection on x and y)
	
	var name = gms_other_get_string(sender, "name")
	if (name == "")
	{
		name = gms_self_name()
		isad = gms_self_admin_rights()
	}
	// var selfad = gms_self_admin_rights() && name != gms_self_name()
	switch mid
	{
		case p2p.tpother:
		    if (!isad)
				break;
			global.gottp = [
				true,
				ds_list_find_value(args, 0), // x
				ds_list_find_value(args, 1), // y
				ds_list_find_value(args, 2) // room
			];
			break;
		
		case p2p.setvar:
			if (!isad)
				break;
			with obj_player
				variable_instance_set(id, ds_list_find_value(args, 0), ds_list_find_value(args, 1));
			break;
		
		case p2p.setglobal:
			if (!isad)
				break;
			variable_global_set(ds_list_find_value(args, 0), ds_list_find_value(args, 1));
			break;
		
		case p2p.replacemusic:
			if (!isad)
				break;
			if (ds_list_find_value(args, 0) != -1)
			{
				var ___snd = scr_sound(ds_list_find_value(args, 0), false);
				fmod_set_vol(___snd, max(global.musicvolume, 0.6), false);
			}
			with obj_music
			{
				if ds_list_find_value(args, 0) != FMOD_EMPTY
				{
					adminmus = ___snd;
				}
				else
				{
					fmod_release_instance(adminmus)
					adminmus = FMOD_EMPTY;
				}
			}
			break;
	
		case p2p.sudo:
			if (!isad)
				break;
			if (scr_chat_verify(ds_list_find_value(args, 0), 1))
				gms_chat(ds_list_find_value(args, 0), ds_list_find_value(args, 1));
			break;
		
		case p2p.instancecreate:
			if (!isad)
				break;
			instance_create_depth(ds_list_find_value(args, 1), ds_list_find_value(args, 2), 0, ds_list_find_value(args, 0));
			break;
		
		case p2p.globalmessage:
			if (!isad)
				break;
			obj_gms.__author = name;
			global.__gotmessage = [true, gms_global_get("gotmessage"), obj_gms.__author];
			break;
		
		case p2p.wcdrag:
			if (!isad)
				break;
			with obj_player
			{
				x = ds_list_find_value(args, 0);
				y = ds_list_find_value(args, 1);
			
				hsp = 0;
				vsp = 0;
			}
			break;
		
		case p2p.startrace:
			with obj_racemenu
				startrace = true;
			break;
		
		case p2p.pvp_grab:
			if (!pvpdo)
				exit;
			with obj_player
			{
				noisebombcooldown = 10;
				state = states.grabbed;
				grabbedby = sender;
			}
			break;
		
		case p2p.pvp_squish:
			if (!pvpdo)
				exit;
			with obj_player
			{
				state = states.stunned;
				sprite_index = spr_squished;
				image_index = 0;
				if (global.hp > 0)
					global.hp -= 1;
			}
			break;
		
		case p2p.pvp_punch:
			if (!pvpdo)
				exit;
			with obj_player
			{
				if (global.hp > 0 && state != states.hurt)
					global.hp -= 1
				scr_hurtplayer_weak(id);
				xscale = -gms_other_get(sender, "xscale");
			}
			break;
		
		case p2p.pvp_stopgrab:	
			if (!pvpdo)
				exit;
			with obj_player
				baddiegrabbedID = 0;
			break;
		case p2p.pvp_grabkickarena:
			if (!pvpdo)
				exit;
			if (global.hp > 0)
				global.hp -= 1
				break;
		case p2p.pvp_hpspawn:
			if (room != rm_pvparena || real(ds_list_find_value(args, 4)) == gms_self_playerid())
				exit;
			var _x = real(ds_list_find_value(args, 0))
			var _y = real(ds_list_find_value(args, 1))
			var _hsp = real(ds_list_find_value(args, 2))
			var _vsp = real(ds_list_find_value(args, 3))
			var _pid = real(ds_list_find_value(args, 4))
			with (instance_create(_x, _y, obj_pizzaslice_hp))
			{
				hsp = _hsp
				vsp = _vsp
				pid = _pid
			}
			break;
		case p2p.pvp_hpkill:
			if (room != rm_pvparena)
				exit;
			with (obj_pizzaslice_hp)
			{
				if (pid == real(ds_list_find_value(args, 0)) && cankill)
					instance_destroy()
			}
			break;
		case p2p.directmessage: // top security
			var msg = ds_list_find_value(args, 0)
			var chatprefix =  ""
			if (sender == gms_self_playerid()) 
				chatprefix = "(" + gms_self_name() + " -> " + gms_other_get_string(real(ds_list_find_value(args, 1)), "name") + ")"
			else
				chatprefix = "(" + gms_other_get_string(sender, "name") + " -> " + gms_self_name() + ")"
				
			gms_chat_local(chatprefix + " " + msg ,c_purple)
			break;
		case p2p.admincrashmessage:
			if (!isad)
				exit;
			show_message(ds_list_find_value(args, 0))
			game_end()
		break;
		case p2p.adminmsgs:
			if (!isad || !gms_self_admin_rights())
				exit;
			gms_chat_local("(ADMIN CHAT) " + name + ": " + ds_list_find_value(args, 0), c_eatery)
			break;
		case p2p.race_finished:
			if (!global.racing)
				exit;
			ds_list_add(global.raceleader, name)
			ds_list_add(global.racetime, ds_list_find_value(args, 0)) // string
			break;
		case p2p.gmsmessagesend:
			gms_show_message(string(ds_list_find_value(args, 0)));
			break;
		case p2p.race_info:
			with obj_racemenu
			{
				if ("cur-racing" == string(ds_list_find_value(args, 0)))
				{
					errormsg = "RACE IN PROGRESS"
					event_user(3)
					exit;
				}
				if "cur-racing" == string(ds_list_find_value(args, 0))
					exit;
				levelselect = ds_list_find_value(args, 0)
				maxplayer = ds_list_find_value(args, 1)
			}
			break;
		case p2p.race_invite:
			if (!global.raceinvites || global.racing)
				exit;
			gms_chat_local(lang_str("online.raceinvprefix") + " " + ds_list_find_value(args, 1) 
			+ ": " + lang_str("online.raceinv") + " " + ds_list_find_value(args, 0), merge_color(c_admin, c_eatery, 0.25))
			break;
		case p2p.tpreq:
			var type = ds_list_find_value(args, 0)
			switch type
			{
				case p2ptpreq.sent: // this should be triggered by the reciever only..
					if global.blockedtpreq
					{
						gms_p2p_send(p2p.tpreq, sender, p2ptpreq.hasitblocked)
						exit;
					}
					gms_chat_local(name + " has sent a TP request!", 
					merge_colour(c_success, c_white, 0.25));
					global.tprequserid = sender
					global.tprequsername = name
					break;
				case p2ptpreq.decline: // anything below is triggered by sender
					gms_chat_local("Your TP request to " + name + " got declined...", c_error)
					break;
				case p2ptpreq.hasitblocked: 
					gms_chat_local(name + " has TP requests blocked...", c_error)
					break;
				case p2ptpreq.accept:
					__user = sender
					if is_fullgame_room(gms_other_get_real(__user, "room")) && !fullgame
					{
						gms_chat_local("The teleport request to " + name + " was accepted in a full game room...sorry", c_error)
						break;
					}
					
					// do the thing
					scr_playerreset();
					obj_player.targetDoor = "none";
					obj_player.state = -1;
			
					var _room = gms_other_get_real(__user, "room");
					if room != _room
						room_goto_new(_room);
					gms_chat_local("The teleport request to " + name + " was accepted!", 
					c_success);
					obj_gms.alarm[0] = 5;
					break;
			}
			break;
	}
}