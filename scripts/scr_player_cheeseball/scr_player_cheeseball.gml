function scr_player_cheeseball()
{
	image_speed = 0.35;
	hsp = xscale * 12
	
	if scr_solid(x + sign(hsp), y)
	&& !place_meeting(x + sign(hsp), y, obj_slope)
	&& !place_meeting(x + sign(hsp), y, obj_destructibles)
	&& !place_meeting(x + sign(hsp), y, obj_cheeseballblock)
	{
		scr_soundeffect(sfx_loseknight)
		grav = basegrav
		repeat 8
			instance_create(x, y, obj_slimedebris)
		
		hsp = 5 * -xscale
		vsp = -3
		visible = true
		image_index = 0
		flash = true
		state = states.bump
		jumpstop = true
	}
	sprite_index = spr_cheeseballed
	
	//Input buffer jumping
	if key_jump
		input_buffer_jump = 0
	
	if !key_jump2 && !jumpstop && vsp < 0.5
	{
		vsp /= 10
		jumpstop = true
	}
	if grounded && vsp > 0
		jumpstop = false
	if !grounded && key_down
		vsp = 10
	
	//Jump
	if input_buffer_jump < 8 && grounded 
	{
		input_buffer_jump = 8
		
		instance_create(x, y, obj_highjumpcloud2)
		scr_soundeffect(sfx_jump)
		vsp = -11
	}
}

