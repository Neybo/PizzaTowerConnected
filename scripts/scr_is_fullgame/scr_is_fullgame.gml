function is_fullgame_room(roomtocheck = room){
	
	var roomnameyeah = room_get_name(roomtocheck)
	return string_startswith(roomnameyeah, "tower") 
	or string_startswith(roomnameyeah, "war")
	or string_startswith(roomnameyeah, "kidsparty") 
	or string_startswith(roomnameyeah, "saloon")
	or string_startswith(roomnameyeah, "FINAL")
	or roomtocheck == secret_entrance
	
}