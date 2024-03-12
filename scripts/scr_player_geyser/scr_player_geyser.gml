function scr_player_geyser()
{
	suplexmove = false;
	sprite_index = spr_geyser;
	image_speed = 0.35;
	
	move = key_left + key_right;
	if move != 0
		xscale = move;
	hsp = move * 4;
	
	if !place_meeting(x, y, obj_geyservertical)
	{
		state = states.jump;
		jumpstop = true;
	}
}

