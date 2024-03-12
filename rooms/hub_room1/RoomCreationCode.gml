if (!variable_global_exists("firstjoin") || !global.firstjoin) && !check_online()
	scr_peploadpal(obj_player, global.palsel)

global.collect = 0
global.combo = 0
global.combotime = 0

video_close()

if !is_holiday(holidays.christmas)
{
	layer_destroy(layer_get_id("Tiles_1_JOLLY"))
	layer_destroy(layer_get_id("Tiles_2_JOLLY"))
}

if (!global.firstjoin)
{
	global.bullet = clamp(3 * (global.usebullet), 0, 3);
	global.ammo = clamp(3 * (global.useammo), 0, 3);
}

if check_online()
{
	global.hp = 0
	// bad code! ew!
	ini_open("saveData.ini")
	global.minichat = ini_read_real("online", "minichat", 0);
	ini_close()
	if !global.firstjoin
	{
		gms_chat_local(lang_str("online.ptc"), merge_color(c_white, c_yellow, 0.5))
		if (instance_exists(obj_player) && obj_player.nickname == "RESET")
		{
			obj_player.nickname = gms_self_name()
			global.storenickname = obj_player.nickname
		}
	}
	
	with obj_shell
		WC_debug = gms_self_admin_rights();
	if !obj_shell.WC_debug
		instance_destroy(obj_wc)
	else if !instance_exists(obj_wc)
		instance_create(0, 0,obj_wc)
		
	gms_session_join(gms_session_id(0))
	global.__script_session = gms_load_start_room;
}
else
{
	global.roommessage = lang_string("roomname.hub_room1");
}
global.golfhit = 0;
global.firstjoin = true

if (!instance_exists(obj_wc) && (debug || !release || !check_online() || gms_self_admin_rights() > 0))
	instance_create(0,0,obj_wc)
	