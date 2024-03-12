/*function scr_chooserandomsecret(){
	var retroom = tower_entrancehall // fallback lmao
	var door = "C"
	with obj_randomsecret
	{
		if secretsleft == 0
			retroom = rank_room // i do not know how it actually works in final game so this is the best
		else
		{
			var num = irandom_range(0, secretsleft - 1)
			retroom = levels[num][0]
			door = levels[num][1]
			array_delete(levels, num, 1)
			secretsleft -= 1
		}
	} // i assume we're warping the player so hold on
	with obj_player
	{
		targetRoom = retroom
		targetDoor = doorX
	}
}*/
function scr_chooserandomsecret_return(){
	var retroom = tower_entrancehall // fallback lmao
	var door = "C"
	with obj_randomsecret
	{
		if secretsleft == 0
		{
			retroom = secret_entrance
			door = "B"
			//	retroom = rank_room // i do not know how it actually works in final game so this is the best
		}
		else
		{
			var num = irandom_range(0, secretsleft - 1)
			retroom = levels[num][0]
			door = levels[num][1]
			array_delete(levels, num, 1)
			secretsleft -= 1
			seconds = 25
			alarm[0] = 60
		}
	} // we are not warping the player this time
	return [retroom, door]
}

function scr_destroy_if_randsecr()
{
	if instance_exists(obj_randomsecret)
		instance_destroy();
}