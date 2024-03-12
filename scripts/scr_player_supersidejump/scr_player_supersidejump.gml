function scr_player_supersidejump(){
	
	hsp = movespeed * xscale * (sprite_index != spr_superjumpsideland)
	
	var move = key_left + key_right
	if move != 0
	{
		if move == xscale
			movespeed = min(movespeed + 0.05, 18)
		else
			movespeed = max(movespeed - 0.05, 6)
	}
	
	vsp = 0
	if key_up
		vsp = -5
	if key_down
		vsp = 5
	vsp = vsp * (sprite_index != spr_superjumpsideland)
	
	if sprite_index == spr_superjumpsideland && animEnd
	{
		state = states.normal
	}
	if place_meeting(x + 2 * xscale, y, obj_solid) 
	&& !place_meeting(x + 2 * xscale, y, obj_destructibles)
	&& sprite_index != spr_superjumpsideland // bump head :(
	{
		if OLD_GAMEPLAY || !key_attack
		{
			sprite_index = spr_superjumpsideland
			image_index = 0
		}
		else
		{
			wallspeed = 12;
			movespeed = 12;
			wallclimbbuffer = 8
			state = states.climbwall;
		}
	}
	if key_down && key_jump2
	{
	    sprite_index = spr_poundcancel1
	    image_index = 0
	    state = states.freefallprep
	    vsp = -7
		exit;
	}
	
	if sprite_index != spr_superjumpsideland
		sprite_index = spr_superjumpside
	image_speed = 0.35
}