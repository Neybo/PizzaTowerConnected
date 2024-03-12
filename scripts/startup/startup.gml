global.pastdisclaimer = false;
global.lapextratime = 50
// trace script
function trace(txt = "trace() at " + string(self))
{
	if !debug
		return;
	
	txt = string(txt);
	show_debug_message(txt);
	
	with obj_wc
	{
		// trace to console
		try
			console_log("[DEBUG] " + txt);
		catch (e)
		{
			// do nothing
			e = 0; // avoid unused variable warn
		}
	}
}

lang_load("en");

// crash
#region report last crash to discord

global.crashed = [false, ""];
if file_exists("lastcrash")
{
	var _e = file_text_open_read("lastcrash");
	var e = string(base64_decode(string(file_text_readln(_e))));
	var whileonline = string(base64_decode(string(file_text_readln(_e)))) == "online" // OMG IT WAS WHILE ONLINE!!!!!! NO WAY!!!!s
	var personname = string(base64_decode(string(file_text_readln(_e))))
	try
	{
		var _room_name = room_get_name(real(file_text_readln(_e)))
	}
	catch(e)
	{
		e = 0;
		var _room_name = "UNDEFINED";
	}
	var testbuild = string(base64_decode(file_text_readln(_e))) == "test";
	global.crashed = [true, e];
	
	if (!whileonline)
	{
		file_text_close(_e)
		if !file_delete("lastcrash")
			trace("last crash file didnt delete dumbass lmfao");
	}
	else
	{
		var body = ds_map_create();
		
		e = string_replace_all(e, "`", "")
		e = string_replace_all(e, "```", "")
		
		ds_map_add(body, "content", "Someone crashed! error:```\n\n" + e  + "\n```\nRoom: `" + _room_name +"`" + (testbuild ? "\n\nON TEST BUILD" : ""));
		ds_map_add(body, "username", "Crash is from \"" + personname + "\"");
		ds_map_add(body, "avatar_url", "https://cdn.discordapp.com/app-assets/828220751810265098/962397483084955699.png");
		
		var data = json_encode(body);
	    ds_map_destroy(body);
				
		var header = ds_map_create();
		ds_map_add(header, "Content-Type", "application/json"); // "multipart/form-data" for files
				
		//http_request(limbo_link_asdihiufhgooCRabguighsbygyh(), "POST", header, data);
		ds_map_destroy(header)
		file_text_close(_e);
		if !file_delete("lastcrash")
			trace("last crash file didnt delete dumbass lmfao");
	}
}

#endregion

if !debug_mode
{
exception_unhandled_handler
(
	function(e)
		{
			fmod_stop_all();
			fmod_create_instance_one_shot(sfx_pephurt);
		
			trace(e);
			show_message(lang_string("general.crashed") + e.longMessage);
			
			if file_exists("lastcrash")
				file_delete("lastcrash");
			
			var _f = file_text_open_write("lastcrash");
		
			// originally meant to have more info
		
			/*
			file_text_write_string(_f, base64_encode(string(e)));
			file_text_writeln(_f);
			file_text_write_string(_f, base64_encode(room_get_name(room)));
			file_text_writeln(_f);
		
			if instance_exists(obj_gms) && gms_info_isloggedin()
			{
				file_text_write_string(_f, base64_encode(gms_self_name()));
				gms_logout();
			}
			else
				file_text_write_string(_f, base64_encode("(noone)"));
			*/
			e = string_replace_all(e, "```", "")
			e = string_replace_all(e, "`", "")
		
			file_text_write_string(_f, base64_encode(string(e)));
			if (check_online())
			{
				file_text_writeln(_f);
				file_text_write_string(_f, base64_encode(string("online")))
				file_text_writeln(_f);
				file_text_write_string(_f, base64_encode(string(gms_self_name())))
			}
			else
			{
				file_text_writeln(_f);
				file_text_write_string(_f, base64_encode(string("offline")))
				file_text_writeln(_f);
				file_text_write_string(_f, base64_encode(string("no-user")))
			}	
			file_text_writeln(_f);
			file_text_write_string(_f, string(room))
			file_text_writeln(_f);
			if (GM_build_type == "run")  
			{ 
				file_text_write_string(_f, base64_encode("test")); 
			} // GameMaker test build
			else 
			{
				file_text_write_string(_f, base64_encode("release")); 
			} // Release build
			file_text_close(_f);
		}
	)
}



// functions
function check_bysync()
{
	if check_online()
		return gms_instance_created_by_sync();
	return false;
}

function create_guid()
{
	var r = "";
	for (var i = 0; i < 32; i++)
	{
		if i == 8 or i == 12 or i == 16 or i == 20
			r += "-";
		r += choose("0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f");
	}
	return r;
}

function check_shaders() {
	return shaders_are_supported();
}

function check_race() {
	return false;
}

function offline_travel()
{
	global.logged = false;
	instance_destroy(obj_gms);
	
	ini_open("saveData" + global.saveslot + ".ini");
	
	// pizzacoin
	if ini_read_real("online", "version", 0) != game_version // version
	{
		scr_setcoin(0);
		ini_write_real("online", "version", game_version);
		ini_write_real("online", "pizzacoin", scr_getcoin());
	}
	else
		scr_setcoin(ini_read_real("online", "pizzacoin", 0));
	global.pizzacoinstart = global.pizzacoin;
	
	// hat unlocks
	global.hatunlock = [true];
	for(var i = 0; i < HATS.length; i++)
	{
		if ini_key_exists("online", "hat" + string(i))
			global.hatunlock[i] = true;
	}
	ini_close();
	
	// travel
	fmod_stop_all();
	with obj_shell
		WC_debug = true;
	
	instance_create(x, y, obj_fadeout)
	with obj_player
	{
		targetDoor = "A";
		targetRoom = hub_room1;
		state = states.door;
	}
}

function get_layer(layer_name)
{
	if layer_exists(layer_name + "_NEW") && FINAL_GAMEPLAY
		layer_name += "_NEW";
	return layer_get_id(layer_name);
}

function room_goto_new(index)
{
	// room_goto but accounts for rooms with _NEW postfix
	// in this case it will redirect you to these in NEW and REMIX gameplay
	
	if (global.leveltype != 0 && !global.snickchallenge) || global.racing
	{
		if asset_get_type(room_get_name(index) + "_NEW") == asset_room
			index = asset_get_index(room_get_name(index) + "_NEW");
	}
	if string_endswith(room_get_name(index), "_NEW") && 
	(global.leveltype == 0 || global.snickchallenge) && !global.racing
	{
		var r = string_replace(room_get_name(index), "_NEW", "");
		if asset_get_type(r) == asset_room
			index = asset_get_index(r);
	}
	
	if index == room
		room_restart();
	else
		room_goto(index);
	return index;
}

function check_online() {
	return instance_exists(obj_gms) && gms_info_isloggedin();
}

function random_bool(percent)
{
	return irandom_range(0, 100) <= percent
}

function name_gms_empty(name, nick, retbool = false)
{
	if nick != name && nick != " " + name && nick != ""
		return (retbool) ? 0 : nick
	else
		return (retbool) ? 1 : name
}

function game_is_compiled()
{
	// worry not this does not steal your discord authentication token
	// this is to check if the game was built or if its running from gms2
	return 1 - sign(string_pos("Runner.exe", parameter_string(0)));
}

function setup_pizzamart()
{
	if obj_player.character == "S" or obj_player.character == "V"
	{
		// shields
		with instance_create(264, 328, obj_pizzashield_collectible)
			ID = "martshotgun1" + string_letters(room_get_name(room));
		with instance_create(265, 333, obj_weaponmachine)
		{
			ID = "martmachine1" + string_letters(room_get_name(room));
			if global.snickrematch
				price = 8;
		}
	}
	else
	{
		// shotguns
		with instance_create(268, 292, obj_shotgun)
			ID = "martshotgun1" + string_letters(room_get_name(room));
		with instance_create(265, 333, obj_weaponmachine)
			ID = "martmachine1" + string_letters(room_get_name(room));
	}
}

function display_values()
{
	var _winw = window_get_width(), _winh = window_get_height();
	var _appw = _winh * (960 / 540), _appx = (_winw - _appw) / 2;
	var _apph = 540 * (_winw / 960), _appy = (_winh - _apph) / 2;
	
	return {
		winw : _winw,
		winh : _winh,
		appw : _appw,
		appx : _appx,
		apph : _apph,
		appy : _appy,
	}
}

gc_enable(true)