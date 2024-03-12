function scr_player_kungfu(){
	var move = key_left + key_right
	hsp = xscale * movespeed
	if move != xscale && move != 0
	{
		movespeed = 0
		hsp = 0
		state = states.normal
		suplexmove = false
		exit;
	}
	if floor(image_index) >= (image_number - 1)
	{
		switch (sprite_index)
		{
			case spr_kungfu1:
			case spr_kungfu2:
			case spr_kungfu3:
				if key_attack
				{
					if character == "N" && noisetype == 0
						state = states.pogo
					else
						state = (movespeed > 12) ? states.mach3 : states.mach2
				}
				else
					state = states.normal;
				if state == states.mach3
					sprite_index = spr_mach4
				image_index = 0
				suplexmove = false
				exit;
				break;
			case spr_kungfuair1transition:
				sprite_index = spr_kungfuair1;
				break;
			case spr_kungfuair2transition:
				sprite_index = spr_kungfuair2;
				break;
			case spr_kungfuair3transition:
				sprite_index = spr_kungfuair3;
				break;
		}
	}
	if grounded && sprite_index != spr_kungfu1 && sprite_index != spr_kungfu2
	&& sprite_index != spr_kungfu3
	{
		if key_attack
		{
			if character == "N" && noisetype == 0
				state = states.pogo
			else
				state = (movespeed > 12) ? states.mach3 : states.mach2
		}
		else
			state = states.normal;
		if state == states.mach3
			sprite_index = spr_mach4
		image_index = 0
		suplexmove = false
		exit;
	}
	//Crouchslide
	if grounded
	{
		if key_down && vsp >= 0 && scr_vigisnickcheck()
		{
			grav = basegrav
			with instance_create(x, y, obj_jumpdust)
		        image_xscale = other.xscale
			scr_soundeffect_ext(sfx_crouchslip, 0, 0.75)
		    movespeed = spd_slide
		    crouchslipbuffer = 25
		    grav = basegrav
		    sprite_index = spr_crouchslip
		    image_index = 0
		    machhitAnim = 0
			if character == "N" && noisetype == 0
				state = states.crouchslide
			else
				state = states.tumble
		}
	}
	else if !(character == "N" && noisetype == 0)
	{
		if key_down && scr_vigisnickcheck() && REMIX_GAMEPLAY
		{
			state = states.tumble
			sprite_index = spr_dive
			vsp = 10
		}
	}
	
	if key_jump && scr_vigisnickcheck()
		input_buffer_jump = 0
	
	if (grounded && input_buffer_jump < 8)
	{
		input_buffer_jump = 8;
		
		image_index = 0
		sprite_index = spr_suplexdashjumpstart
		
		jumpstop = 0
		vsp = -11
		
		if FINAL_GAMEPLAY && !(character == "N" && noisetype == 0)
		{
			state = states.mach2;
			if spr_longjump != spr_player_longjump || character == "P"
				sprite_index = spr_longjump
			else
				sprite_index = spr_mach2jump;
		}
		else
		{
			scr_soundeffect(sfx_jump)
			instance_create(x, y, obj_highjumpcloud2)
		}
	}
	var slop = scr_slope();
	var bump = climb_wall();
	if bump 
	{
		if (grounded && !slop)
		{
			sprite_index = spr_kungfujump
			image_index = 0
			state = states.punch
			vsp = -4
			movespeed = -6
		}
		else
		{
			if character == "N" && noisetype == 0
			{
				state = states.hang
				sprite_index = spr_playerN_wallclingstart
				image_index = 0
				xscale *= -1
				vsp = 0
				doublejump = false
			}
			else
			{
				wallspeed = movespeed
				if (global.slopebitch)
				{
					if vsp > 0 && FINAL_GAMEPLAY
						wallspeed -= vsp
					vsp = -wallspeed
				}
				wallclimbbuffer = 8
				state = states.climbwall
			}
		}
	}
	if key_slap2
	{
		scr_player_dosuplexdash()
	}
	image_speed = 0.35
}