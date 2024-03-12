function scr_player_crouchslide()
{
	var railh = 0, railmeet = instance_place(x, y + 1, obj_railparent);
	if railmeet then railh = railmeet.spdh;
	hsp = xscale * movespeed + railh;


	if movespeed >= 0 && grounded
		movespeed -= 0.2
	
	if NOT_FINAL_GAMEPLAY_ONLY
	{
		if !key_jump2 && !jumpstop && vsp < 0.5 && !stompAnim
		{
			vsp /= 10;
			jumpstop = true;
		}
		if key_jump
			input_buffer_jump = 0;
		
		if !grounded && character == "SP"
			sprite_index = spr_playerSP_jumpdive2;
		
		if grounded && input_buffer_jump < 8 && !scr_solid(x + 27 * xscale, y - 32) 
		&& !scr_solid(x, y - 16)
		{
			input_buffer_jump = 8;
			if character == "P"
			{
				scr_soundeffect(sfx_jump)
				
				sprite_index = spr_player_jumpdive1
				image_index = 0
				vsp = -11
				jumpstop = false
				
				with instance_create(x, y, obj_superdashcloud)
				{
					image_xscale = other.xscale
					other.dashcloudid = id
				}
			}
			else
			{
				scr_soundeffect(sfx_jump)

				sprite_index = spr_jump
				momentum = true
				
				if shotgunAnim && character != "SP"
					sprite_index = spr_shotgunjump
				with instance_create(x, y, obj_highjumpcloud2)
					image_xscale = other.xscale
		
				vsp = -11
				
				state = states.jump
				
				image_index = 0
				jumpAnim = true
			}
		}
	}
	
	mask_index = spr_crouchmask
	/*
if (grounded && key_attack2 && !scr_solid(x + 27 * xscale, y - 32) && !scr_solid(x, y - 16)) && (character != "N" or (character == "N" && noisetype == 1))
	{
		movespeed = 14
		state = states.mach3
		image_index = 0
		sprite_index = spr_rollgetup
	}
*/
	
	var minspeed = 5;
	if scr_pizzyphys_check()
		minspeed = 0;
	
	if (movespeed <= minspeed or (scr_solidwall(x + xscale, y) 
	&& !place_meeting(x + sign(hsp), y, obj_destructibles)))
	{
		if !key_down && grounded && !(scr_solid(x, y - 16) || scr_solid(x, y - 32))
			state = states.normal
		else
			state = states.crouch
	}
	
	if !instance_exists(obj_slidecloud) && grounded && movespeed > 5
	{
		with instance_create(x, y, obj_slidecloud)
			image_xscale = other.xscale
	}
	
	if sprite_index == spr_breakdancesuper or FINAL_GAMEPLAY
		image_speed = movespeed / 24;
	else
		image_speed = 0.4;
}