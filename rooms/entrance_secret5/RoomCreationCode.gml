if check_online() && gms_other_count() > 0
	global.roommessage = lang_str("roomname.online.entrance_secret5")
else
	global.roommessage = lang_str("roomname.offline.entrance_secret5")
