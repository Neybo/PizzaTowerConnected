function scr_player_breakdance(){
	if !key_taunt
	{
		state = states.normal
		exit;
	}
	breakdancetime += delta_time / 1000000 // DT on a frame-based game isn't the best of things
										   // But considering that it's just for funny it's fine ig
										   // sure, why not
	if breakdancetime % 3 > 1.5
		sprite_index = spr_breakdancesuper
	else if sprite_index != spr_breakdancestart
		sprite_index = spr_breakdance
		
	if scr_anim_end() && spr_breakdancestart == sprite_index
		sprite_index = spr_breakdance
	
	move = key_left + key_right;
	if move != 0
		xscale = move;
	movespeed = 0; // prevents breakdance movespeed conservation
	hsp = move * 5;
	image_speed = 0.5
}