function scr_player_fling()
{
	if sprite_index == spr_playerSP_candybegin && image_index >= image_number - 1
		sprite_index = spr_playerSP_candyidle;
	image_speed = 0.35;
	
	suplexmove = false;
	
	move = key_left + key_right;
	if dir != move
	{
		dir = move;
		hsp = 0;
	}
	
	if move != 0
	{
		xscale = move;
		if abs(hsp) < 8
			hsp += 0.25 * move;
	}
	else
		hsp = 0;
	
	if abs(hsp) > 0 && scr_solid(x + xscale, y)
		hsp = xscale * -4;
	
	vsp -= 1;
	if key_jump
	{
		image_index = 0;
		sprite_index = spr_playerSP_candytransitionup;
		jumpAnim = true;
		state = states.jump;
		vsp = -6;
		jumpstop = true;
		instance_destroy(candyeffect);
		scr_soundeffect(sfx_flingfrogjump);
	}
}

