function sh_room(args)
{
	if !WC_debug
		return "You do not have permission to use this command";
	if array_length(args) < 2
		return "The current room is " + room_get_name(room) + " (" + string(room) + ")";
	
	var roomgoto = args[1];
	
	if string_is_number(roomgoto)
	{
		roomgoto = real(roomgoto);
		if !room_exists(roomgoto)
			return "The room " + string(roomgoto) + " doesn't exist";
		else
			return "Room id of " + string(roomgoto) + " equals " + room_get_name(roomgoto);
	}
	else if asset_get_type(roomgoto) != asset_room
		return "The asset " + roomgoto + " is not a room";
	else 
	{
		roomgoto = asset_get_index(roomgoto);
	}	
	
	if is_fullgame_room(roomgoto) and !fullgame
		return "Buy Pizza Tower! Then you can go to these rooms."
	
	var door = "NONE";
	if array_length(args) >= 3
		door = args[2];
	
	with obj_player
		targetDoor = door;
	
	room_goto(roomgoto);
	
	scr_soundeffect(sfx_door);
	instance_create(0, 0, obj_fadein);
}
function meta_room()
{
	return {
		description: "travel to a room",
		arguments: ["targetRoom", "<targetDoor>"],
		suggestions: [
			function()
			{
				var room_array = [];
				for(var i = 0; room_exists(i); i++)
					array_push(room_array, room_get_name(i));
				array_sort(room_array, true);
				return room_array;
			},
			["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K"]
		],
		argumentDescriptions: [
			"room to travel to, input as name or index",
			"(optional) door index to place the player at"
		],
	}
}

