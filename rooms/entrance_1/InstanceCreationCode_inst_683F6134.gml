prompt_condition = function()
{
	with obj_player
	{
		if ((sprite_index == spr_Timesup && floor(image_index) >= image_number - 2) 
		or state == states.normal)
		&& (place_meeting(x, y, obj_exitgate) or character == "S")
			return true;
	}
	return false;
}
visible = false;

var str1 = "It seems the gate behind the pizzaman has slammed shut! No way around it.";
var str2 = "Looks like this odd-looking man will have to explore this deeply strange place...";

if instance_exists(obj_player)
{
	switch obj_player.character
	{
		case "SP":
		case "SN":
			str1 = "It seems as though our infamous candyman has ended in a completely different universe!";
			str2 = "It looks like he will have to explore this deeply strange place...";
			break;
		case "N":
			str1 = "It seems the gate behind the gremlin has slammed shut! No way around it.";
			break;
		case "V":
			str1 = "It seems the gate behind the cowboy has slammed shut! No way around it.";
			str2 = "Looks like this, uh, living cheese will have to explore this deeply strange place...";
			break;
		case "S":
			str1 = "It seems the gate has magically disappeared when this porcupine came around! No way around it.";
			str2 = "Looks like this odd-looking creature will have to explore this deeply strange place...";
			break;
		case "PP":
			str1 = "It seems the gate behind the dripping piss man has slammed shut! No way around it.";
			str2 = "Looks like this odd man will have to explore this deeply strange place...";
			break;
	}
}

prompt_array[0] = tv_create_prompt(str1, false, spr_tv_idleanim1, 3);
prompt_array[1] = tv_create_prompt(str2, true, spr_tv_idleanim2, 3);
