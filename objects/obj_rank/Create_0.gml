image_speed = 0.5
depth = -8
suy = -100
ended = 0
scr_initinput()
if scr_checkskin(checkskin.p_anton)
	alarm[0] = 100;
else
{
	alarm[0] = 500;
	if obj_player.character == "SP" || obj_player.character == "SN" {
		alarm[0]  = -1
		alarm[1] = 680
	}
	if obj_player.character == "PP"
		alarm[0] += 180;
	
	if global.rank == "d" && !check_sugary(,true)
	{
		alarm[0] += 42;
		if global.musicgame == 1
			alarm[0] += 10;
	}
	
	if global.rank == "yousuck"
	{
		alarm[0] = 180 * 23;
		if global.musicgame == 1
			alarm[0] = 360;
	}
}
surf = -4

if obj_player.character == "P" // peppino
{
	if global.rank == "s"
		sprite_index = scr_prankvalid() ? spr_rankP : spr_rankS
	if global.rank == "a"
		sprite_index = spr_rankA
	if global.rank == "b"
		sprite_index = spr_rankB
	if global.rank == "c"
		sprite_index = spr_rankC
	if global.rank == "d" or global.rank == "eggplant"
		sprite_index = spr_rankD
}
else if obj_player.character == "SP" || obj_player.character == "SN" // pizzelle
{
	if global.rank == "s"
		sprite_index = scr_prankvalid() ? spr_rankSPP : spr_rankSPS
	if global.rank == "a"
		sprite_index = global.newpizzy ? spr_rankSPANEW : spr_rankSPA
	if global.rank == "b"
		sprite_index = spr_rankSPB
	if global.rank == "c"
		sprite_index = spr_rankSPC
	if global.rank == "d" or global.rank == "eggplant"
		sprite_index = spr_rankSPD
}
else if obj_player.character == "PP" // pissino the greatest
{
	if global.rank == "s"
		sprite_index = scr_prankvalid() ? spr_rankPPP : spr_rankPPS
	if global.rank == "a"
		sprite_index = spr_rankPPA
	if global.rank == "b"
		sprite_index = spr_rankPPB
	if global.rank == "c"
		sprite_index = spr_rankPPC
	if global.rank == "d" or global.rank == "eggplant"
		sprite_index = spr_rankPPD
}
else // noise
{
	if global.rank == "s"
		sprite_index = spr_rankNS
	if global.rank == "a"
		sprite_index = spr_rankNA
	if global.rank == "b"
		sprite_index = spr_rankNB
	if global.rank == "c"
		sprite_index = spr_rankNC
	if global.rank == "d" or global.rank == "eggplant"
		sprite_index = spr_rankND
}
if global.rank == "yousuck"
	sprite_index = spr_yousuck