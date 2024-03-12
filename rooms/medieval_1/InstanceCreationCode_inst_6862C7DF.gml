prompt_condition = function()
{
	with obj_player
	{
		if ((sprite_index == spr_Timesup && floor(image_index) == image_number - 2) or state == states.normal)
		&& (place_meeting(x, y, obj_exitgate) or global.snickchallenge)
			return true;
	}
	return false;
}

if global.snickchallenge
{
	if global.snickrematch
		prompt_array[0] = tv_create_prompt("SNICK IS COMING SNICK IS COMING SNICK IS COMING SNICK IS COMING SNICK IS COMING SNICK IS COMING SNICK IS COMING SNICK IS COMING SNICK IS COMING SNICK IS COMING SNICK IS COMING SNICK IS COMING SNICK IS COMING SNICK IS COMING", false, spr_tv_glitching, 32);
	else
	{
		var characterstring = "a fat italian man";
		switch obj_player.character
		{
			case "N": characterstring = "a crazed psycho"; break;
			case "V": characterstring = "a walking cheese pudding"; break;
			case "S": characterstring = "a clone of itself"; break;
			case "SP": characterstring = "our beloved Pizzelle Theodore"; break;
			case "PP": characterstring = "a mistake"; break;
		}
		
		prompt_array[0] = tv_create_prompt("PTV seems to have catched on camera a glimpse of flying purple porcupine following " + characterstring + " in this area.", false, spr_tv_idleanim1, 3);
		prompt_array[1] = tv_create_prompt("We are currently not sure what to make of this, but I suggest we roll with it as it does provide interesting footage.", false, spr_tv_idleanim1, 3);
		//prompt_array[1] = tv_create_prompt("Wait a minute, is that the same color as the so called toppings on this pizza?", false, spr_tv_idleanim2, 3);
	}
}
else
	prompt_array[0] = tv_create_prompt("PTV seems to have catched on camera a glimpse of strange magical cult wearing robes or bathrobes, we cannot tell which but it seems frankly irrelevant.", false, spr_tv_idleanim1, 3);

