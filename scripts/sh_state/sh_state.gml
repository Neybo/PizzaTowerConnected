function sh_state(args)
{
	if !WC_debug
		return "You do not have permission to use this command";
		
	if !instance_exists(obj_player)
		return "The player is not in the room";
	if array_length(args) < 2
		return "The current player state is " + obj_player.state;
	
	var _state = args[1];
	if string_is_number(_state)
	{
		with obj_player
			state = real(_state);
		return "Set the player's state to " + _state;
	}
	else
	{
		return "Must be string";
	}
}
function meta_state()
{
	return {
		description: "change the player's state",
		arguments: ["state"],
		suggestions: [],
	}
}

