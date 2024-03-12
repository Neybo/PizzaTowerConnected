function sh_gameplay(args)
{
	if !WC_debug && room != hub_room1
		return "You can only do this in OFFLINE mode or in the first hub room.";
	
	// actual command
	var g = string_lower(args[1]);
	if g == "old"
		g = 0;
	if g == "new"
		g = 1;
	if g == "remix"
		g = 2;
	
	if is_string(g) && string_is_number(g)
		g = real(g);
	
	if g != 0 && g != 1 && g != 2
		return "Invalid gameplay style " + string(g);
	
	global.gameplay = g;
	with obj_player
		targetDoor = "NONE";
	room_restart();
}
function meta_gameplay()
{
	return
	{
		description: "change the gameplay style",
		arguments: ["style"],
		suggestions: [
			["old", "new", "remix"]
		],
		argumentDescriptions: [
			"the gameplay style to switch to",
		],
	}
}

