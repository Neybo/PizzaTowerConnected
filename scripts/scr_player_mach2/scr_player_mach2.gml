function scr_player_mach2()
{
	if windingAnim < 2000 && character == "P"
		windingAnim++
	
	var railh = 0, railmeet = instance_place(x, y + 1, obj_railparent);
	if railmeet then railh = railmeet.spdh;
	hsp = xscale * movespeed + railh;
	
	move2 = key_right2 + key_left2
	move = key_right + key_left

	crouchslideAnim = true

	//Jump Stop
	if !key_jump2 && !jumpstop && vsp < 0.5 
	{
		vsp /= 10
		jumpstop = true
	}
	
	//Uppercut
	if key_up && key_slap2 && FINAL_GAMEPLAY && !global.slopebitch && character != "S"
	{
		fmod_play_instance(suplexdashsnd);
				
		state = states.punch;
		image_index = 0;
		sprite_index = spr_breakdanceuppercut;
		vsp = -10;
		movespeed = hsp;
		instance_create(x, y, obj_highjumpcloud2);
				//instance_create(x, y, obj_swingdinghitbox);
		exit; // Don't go any further the state's script
	}
	
	//Input buffer jumping
	if key_jump
		input_buffer_jump = 0

	//Jump
	if input_buffer_jump < 8 && grounded && move != -xscale
	{
		jumpstop = false
		input_buffer_jump = 8
		
		image_index = 0
		sprite_index = spr_secondjump1
		scr_soundeffect(sfx_jump)

		vsp = -11
	}
	
	// mort jump
	if key_jump && global.mort && !doublejump && !grounded && !skateboarding
	{
		state = states.jump;
		repeat 6 with instance_create(x, y, obj_debris)
			sprite_index = spr_feather;
			
		scr_soundeffect(sfx_woosh);
		sprite_index = spr_pmortjumpstart;
		image_index = 0;
		jumpstop = false;
		jumpAnim = false;
		
		grav = 0.25;
		mort = 1;
		exit;
	}
	
	//Animations
	if grounded && vsp >= 0
	{
		if machpunchAnim
		{
			if !punch && sprite_index != spr_machpunch1
			{
				image_index = 0;
				sprite_index = spr_machpunch1
			}

			if punch && sprite_index != spr_machpunch2
			{
				image_index = 0;
				sprite_index = spr_machpunch2
			}
			
			if floor(image_index) >= image_number - 1 && sprite_index == spr_machpunch1
			{
				punch = true
				machpunchAnim = false
			}

			if floor(image_index) >= image_number - 1 && sprite_index == spr_machpunch2
			{
				punch = false
				machpunchAnim = false
			}
		}
		else if sprite_index != spr_mach && sprite_index != spr_mach1 && sprite_index != spr_mach4 && sprite_index != spr_player_machhit
		&& sprite_index != spr_snick_tumble && (sprite_index != spr_snick_bodyslamstart or grounded)
		&& sprite_index != spr_superjumpcancelstart
		{
			if sprite_index != spr_rollgetup or character == "S"
				sprite_index = spr_mach
		}
	}
	if floor(image_index) == image_number - 1 && sprite_index == spr_mach1
        sprite_index = spr_mach
    if floor(image_index) >= image_number - 1 && sprite_index == spr_longjump
        sprite_index = spr_longjumpend
	
	if !grounded
	{
		machpunchAnim = false
		if sprite_index == spr_snick_tumble
			sprite_index = spr_snick_bodyslamstart;
	}
	
	//Mach Freefall
	//if !(grounded) && vsp > 0 
	//{
	//++machfreefall
	//if machfreefall > 30
	//state = states.machfreefall
	//} 
	//else
	//machfreefall = 0


	//Mach3
	if grounded
	{
		if hsp != 0 && movespeed > 8
			scr_player_addslopemomentum(0.1, 0.2);
		
		if movespeed < 8 && OLD_GAMEPLAY
			movespeed = 8;
			
		if vsp > 0
			jumpstop = false;
		
		if movespeed < 12
		{
			movespeed += 0.1
		}
		else
		{
			//movespeed = 12
			machhitAnim = false
			state = states.mach3
			flash = true
			
			if sprite_index != spr_rollgetup
				sprite_index = spr_mach4
			with instance_create(x, y, obj_jumpdust)
				image_xscale = other.xscale
		}
	}

	//Machroll
	if ((key_down && !scr_pizzyphys_check()) or key_down2) && !place_meeting(x, y, obj_dashpad)
	{
		if scr_pizzyphys_check() && OLD_GAMEPLAY
		{
			if grounded
			{
				sprite_index = spr_crouchslip
				state = states.crouchslide
				return;
			}
		}
		else
		{
			with instance_create(x, y, obj_jumpdust)
				image_xscale = other.xscale
			
			flash = false
			if OLD_GAMEPLAY
				state = states.machroll
			else
			{
				state = states.tumble
				if !grounded
		            sprite_index = spr_mach2jump
		        else
		            sprite_index = spr_machroll
			}
			
			vsp = 10
			if character == "V"
				sprite_index = spr_playerV_divekickstart
			return;
		}
	}
	
	// Climbwall
	var slop = scr_slope();
	var bump = climb_wall();
	
	if bump && (slop or !grounded)
	{
		if !grounded or (!scr_solidwall(x, y - 32) or place_meeting(x, y - 32, obj_destructibles))
		{
			if (!key_attack && character != "S") or (character == "S" && move == 0)
			{
				instance_create(x, y + 43, obj_cloudeffect)
			
				vsp = -movespeed
				state = states.normal
				movespeed = 0
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
				wallclimbbuffer = 0
				state = states.climbwall
			}
		}
	}
	
	if state != states.climbwall && grounded && bump
	{
		if !ledge_bump()
		{
			if OLD_GAMEPLAY
			{
				movespeed = 0
				state = states.normal
			}
			else
			{
				scr_soundeffect(sfx_splat)
				state = states.bump
                image_index = 0
                if spr_splat != spr_player_wallsplat || character == "P"
					sprite_index = spr_splat
				else
					sprite_index = spr_bump
			}
		}
	}
	
	//Effect
	if !instance_exists(dashcloudid) && grounded
	{
		with instance_create(x, y, obj_dashcloud)
		{
			image_xscale = other.xscale
			other.dashcloudid = id
		}
	}
	
	if !instance_exists(speedlineseffectid) && grounded && FINAL_GAMEPLAY
	{
		with instance_create(x, y, obj_speedlines)
		{
			image_xscale = other.xscale
			other.speedlineseffectid = id
		}
	}
	
	if grounded && floor(image_index) >= image_number - 1 && sprite_index == spr_rollgetup
	{
		if character == "P" && REMIX_GAMEPLAY
			sprite_index = spr_player_machhit
		else
			sprite_index = spr_mach
	}

	if !grounded && sprite_index != spr_secondjump2 && sprite_index != spr_mach2jump 
	&& sprite_index != spr_walljumpstart && sprite_index != spr_walljumpend 
	&& sprite_index != spr_machroll && sprite_index != spr_longjump 
	&& sprite_index != spr_longjumpend
		sprite_index = spr_secondjump1

	if floor(image_index) = image_number -1 && sprite_index = spr_secondjump1
		sprite_index = spr_secondjump2

	if floor(image_index) >= image_number - 1 && sprite_index = spr_walljumpstart && character != "S"
		sprite_index = spr_walljumpend
	
	//Snick peelout
	if key_attack && !scr_solid(x + xscale, y, false) && character == "S" && grounded && vsp >= 0
	{
		state = states.handstandjump
		movespeed = 0
	}
	
	if grounded
		pizzymidairgrab = 0

	//Back to other states
	if (!key_attack or character == "S") && move != xscale && grounded && vsp >= 0
	{
		image_index = 0
		state = states.machslide
		scr_soundeffect(sfx_break)
		sprite_index = spr_machslidestart
	}

	if move == -xscale && grounded && character != "S" && vsp >= 0
	{
		scr_soundeffect(sfx_machslideboost)
		image_index = 0
		state = states.machslide
		
		sprite_index = spr_machslideboost
	}
	
	//Vigilante revolver
	if key_slap2 && character == "V"
	{
		vsp = -5
		state = states.revolver	
		image_index = 0
		sprite_index = spr_playerV_airrevolver
		image_index = 0
		with instance_create(x + xscale * 20, y + 20, obj_shotgunbullet)
			shotgun = true
		scr_soundeffect(sfx_killingblow)
	}
	
	//Vigilante Dynamite
	if key_shoot2 && character == "V" && !instance_exists(obj_dynamite)
	{
		vsp = -5

		state = states.dynamite
		image_index = 0
		sprite_index = spr_playerV_dynamitethrow
		with instance_create(x, y, obj_dynamite)
		{
			image_xscale = other.xscale
			movespeed = other.movespeed + 4
			vsp = -6
		}
	}

	if move == xscale && !key_attack && grounded && vsp >= 0 && character != "S"
	{
		if scr_pizzyphys_check() && freefallstart == 1
		{
			scr_soundeffect(_sfx_step)
			landAnim = true
			instance_create(x, y, obj_landcloud)
			input_buffer_secondjump = 0
			state = states.normal
			jumpAnim = true
			jumpstop = false
			image_index = 0
		
			freefallstart = 0
		}
		else
			state = states.normal
	}
	
	if OLD_GAMEPLAY
		image_speed = 0.5
	else if sprite_index == spr_rollgetup
        image_speed = 0.4
    else
        image_speed = abs(movespeed) / 15
	
	if FINAL_GAMEPLAY
		scr_player_suplexmoves()
	
	//Taunt
	if key_taunt2 
		scr_player_taunt();
	scr_shootandchainsaw();
}
