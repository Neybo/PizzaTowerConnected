function sh_speed(args)
{
	if global.racing
		return "Don't cheat :)";
	if !WC_debug && string_is_number(spd) && real(spd) > 60
		return "Ouch. Too fast for me. Keep it 60 or below."
	if array_length(args) < 2
		return "Missing argument: speed";
	
	var spd = args[1];
	if string_is_number(spd)
	{
		room_speed = real(spd);
		return "Set room speed to " + string(room_speed);
	}
	else
		return "Speed parameter must be a number";
}
function meta_speed()
{
	return {
		description: "set the game's maximum FPS. depending on your setup it might not go over 60",
		arguments: ["speed"],
		suggestions: [
			function()
			{
				if room_speed != 60
					return [60, room_speed];
				return [60];
			}
		],
		argumentDescriptions: [
			"the number to set the maximum FPS to",
		],
	}
}

