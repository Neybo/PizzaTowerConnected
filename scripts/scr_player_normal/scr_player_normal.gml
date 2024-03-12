function scr_player_normal()
{
	mach2 = 0;
	move = key_left + key_right;
	skateboarding = false;
	momentum = false;
	jumpstop = false;
	
	//Turn
	if dir != xscale
	{
		dir = xscale
		movespeed = 2 
		facehurt = false
	}
	
	// on rail
	var railh = 0, railmeet = instance_place(x, y + 1, obj_railparent);
	if railmeet then railh = railmeet.spdh;
	hsp = move * movespeed + railh;
	
	// hardoween noise physics
	var _acc = 0.5;
	var _msp = OLD_GAMEPLAY ? 6 : 8;
	if scr_pizzyphys_check() && FINAL_GAMEPLAY
		_msp = 7;
	
	if grounded
		pizzymidairgrab = 0
	
	//Idles Anim
	var outoftime = !instance_exists(obj_toppinwarrior) 
	&& ((OLD_GAMEPLAY && global.minutes <= 0 && global.seconds <= 0) 
	or (FINAL_GAMEPLAY && global.panic && global.fill <= 0));
	
	if sprite_index == spr_shotgunshoot
		move = move * (xscale == move)
	
	if character != "S"
	{
		if move != 0 
		{
			xscale = move
			
			//Movespeed
			if movespeed < _msp
				movespeed += _acc;
			else if floor(movespeed) == _msp
				movespeed = _msp;
			
			var mv = movespeed / 6;
			image_speed = lerp(0.35, 0.6, floor(mv) + (floor(frac(mv) * 100) / 100)); // limit to 2 decimal places
			
			if sprite_index == spr_land
				landAnim = false;
			
			if !machslideAnim && !landAnim && !shotgunAnim
			{
				machslideAnim = false
				idle = 0
				facehurt = false
				
				if shot
					sprite_index = spr_pistolwalk
				else if mort
					sprite_index = spr_pmortwalk
				else if global.stylethreshold == 2 && character != "SP"
					sprite_index = spr_3hpwalk
				else if global.stylethreshold >= 3 && character != "SP"
					sprite_index = spr_ragemove
				else if outoftime
					sprite_index = spr_hurtwalk
				else if angry && NOT_FINAL_GAMEPLAY_ONLY
					sprite_index = spr_3hpwalk
				else
					sprite_index = spr_move
			}
		}
		else
		{
			image_speed = 0.35;
			movespeed = 0;
			if !machslideAnim && !landAnim && !shotgunAnim
			{
				if move == 0
				{
					if idle < 400 && character != "SP"
						idle++;
					else
						idle = 0;
					
					if idle >= 150
					{
						facehurt = false;
						if sprite_index != spr_idle1 && sprite_index != spr_idle2 
						&& sprite_index != spr_idle3 && sprite_index != spr_idle4  
						&& sprite_index != spr_idle5  && sprite_index != spr_idle6 
						&& sprite_index != spr_player_idlelook && sprite_index != spr_playerSP_keyidle
						&& sprite_index != spr_freezeridle
						{
							randomise()
							if FINAL_GAMEPLAY
							{
								if (irandom(3) <= 1 && character = "N")
									scr_soundeffect(sfx_noiseidle);
								else if (irandom(4) <= 1)
								{
									if character = "P"
										scr_soundeffect(sfx_pepidle);
									else if character = "V"
										scr_soundeffect(sfx_vigiidle)
								}
							}
									
							sprite_index = choose(spr_idle1, spr_idle2, spr_idle3, 
							spr_idle4, spr_idle5, spr_idle6);
							if insidefreezer
								sprite_index = spr_freezeridle
							image_index = 0
						}
						else if floor(image_index) >= image_number - 1
						{
							idle = irandom_range(-50, 15);
							image_index = 0
						}
					}
					
					if idle < 150
					{
						if !facehurt
						{
							if windingAnim < 1800 or angry or global.playerhealth == 1 or shot
							{
								start_running = true
								movespeed = 0
							
								if sprite_index != spr_playerV_revolverend
								{
									if shot
										sprite_index = spr_pistolidle
									else if mort
										sprite_index = spr_pmortidle
									else if global.stylethreshold == 2 && character != "SP"
										sprite_index = spr_3hpidle
									else if global.stylethreshold >= 3 && character != "SP"
										sprite_index = spr_rageidle
									else if outoftime
										sprite_index = spr_hurtidle
									else if global.panic or global.snickchallenge
										sprite_index = spr_panic
									else if angry && NOT_FINAL_GAMEPLAY_ONLY
										sprite_index = spr_3hpidle
									else
										sprite_index = spr_idle
								}
							}
							else
							{
								idle = 0
								sprite_index = spr_winding
							}
							
							if windingAnim > 0
								windingAnim--;
						}
						else
						{
							windingAnim = 0
							if sprite_index != spr_facehurtup && sprite_index != spr_facehurt
								sprite_index = spr_facehurtup
							if floor(image_index) >= image_number - 1 && sprite_index == spr_facehurtup
								sprite_index = spr_facehurt
						}
					}
				}
			}
		}
	}
	
	if movespeed > _msp
		movespeed -= 0.1
	
	// snick idle animation
	if character == "S"
	{
		if !machslideAnim
		{
			image_speed = 0.35;
			if move == 0
			{
				if idle < 400
					idle++
				if idle >= 100
				{
					if sprite_index != spr_idle && floor(image_index) >= image_number - 1
					{
						idle = 0
						image_index = 0
					}
					if sprite_index != spr_idle1 
						sprite_index = spr_idle1
				}
				else
					sprite_index = spr_idle
			}
			if move != 0 
			{
				machslideAnim = false
				sprite_index = spr_move
				xscale = move
			}
		}
	}
	
	//Land Anim
	if landAnim
	{
		if sprite_index == spr_pmortland
		{
			if floor(image_index) >= image_number - 1
			{
				landAnim = false
				sprite_index = spr_pmortidle
				image_index = 0
			}
		}
		else if !shotgunAnim
		{
			if move == 0
			{
				movespeed = 0
				sprite_index = spr_land
				if floor(image_index) >= image_number - 1
					landAnim = false
			}
			else
			{
				sprite_index = spr_land2
				
				if floor(image_index) >= image_number -1
				{
					landAnim = false
					sprite_index = spr_move
					image_index = 0
				}
			}
		}
		else
		{
			sprite_index = spr_shotgunland
			if floor(image_index) >= image_number - 1
			{
				landAnim = false
				sprite_index = spr_shotgunidle
				if move != 0
					sprite_index = spr_shotgunwalk
				image_index = 0
			}
		}
	}
	
	//MachSlide End Anim
	if machslideAnim
		sprite_index = spr_machslideend
	else if !landAnim && shotgunAnim && sprite_index != spr_shotgunshoot
		sprite_index = (move != 0 ? spr_shotgunwalk : spr_shotgunidle);
	
	if floor(image_index) >= image_number - 1
	{
		if machslideAnim
		{
			landAnim = false;
			machslideAnim = false;
		}
		switch sprite_index
		{
			case spr_playerV_revolverend:
				sprite_index = spr_idle;
				break;
			case spr_shotgunshoot:
				sprite_index = spr_shotgunidle;
				if key_attack && REMIX_GAMEPLAY
				{
					movespeed = tauntstoredmovespeed
					if movespeed > 12
					{
						machhitAnim = false
						state = states.mach3
						flash = true
			
						if sprite_index != spr_rollgetup
						{
							sprite_index = spr_mach4
							image_index = 0
						}
					}
					else
					{
						state = states.mach2
						sprite_index = spr_mach1
						jumpAnim = true
						image_index = 0
					}
					return;
				}
				break;
		}
	}
	
	if scr_solid(x + xscale, y) && move == xscale 
	&& (!place_meeting(x + xscale, y, obj_slope) or scr_solid_slope(x + xscale, y) 
	or scr_solidwall(x, y - 1))
		movespeed = 0
	
	if grounded
	{
		//Jump
		if (key_jump or (input_buffer_jump < 8 && !key_attack && vsp > 0)) && !key_down
		{
			scr_soundeffect(sfx_jump)
			
			if sprite_index != spr_shotgunshoot
			{
				if shotgunAnim && character != "SP"
					sprite_index = spr_shotgunjump
				else if outoftime
					sprite_index = spr_player_hurtjump
				else
					sprite_index = spr_jump
				image_index = 0
			}
			
			with instance_create(x, y, obj_highjumpcloud2)
				image_xscale = other.xscale
			
			stompAnim = false
			vsp = -11
			if scr_pizzyphys_check() or character == "SN"
				vsp = -12
			
			state = states.jump
			jumpAnim = true
			jumpstop = false

			freefallstart = 0
		}
		
		//Crouch
		if (key_down or scr_solid(x, y - 3)) && character != "S" && sprite_index != spr_playerV_revolverend
		{
			state = states.crouch
			landAnim = false
			crouchAnim = true
			image_index = 0
			idle = 0
		}
		
		//Snick peelout
		if key_attack && character == "S" && vsp >= 0
		{
			if move != 0
				xscale = move
			state = states.handstandjump
			movespeed = 0
			
			exit;
		}
		
		// Snick spindash
		if key_down && (key_jump or key_slap2) && character == "S" && vsp >= 0
		{
			movespeed = 0
			state = states.spindash
			key_jump = false
			scr_soundeffect(sfx_jump)
			
			with instance_create(x, y, obj_dashcloud)
			{
				image_xscale = other.xscale
				other.dashcloudid = id
			}
			
			exit;
		}
	}
	else if !key_jump // fall off
	{
		if sprite_index != spr_shotgunshoot
		{
			if !shotgunAnim or character == "SP"
			{
				if global.minutes <= 0 && global.seconds <= 0 && 
				character == "P" && !instance_exists(obj_toppinwarrior)
					sprite_index = spr_player_hurtjump2
				else
					sprite_index = spr_fall
			}
			else
				sprite_index = spr_shotgunfall
			jumpAnim = false
			state = states.jump
		}
	}
	
	//Suplex Dash
	if key_slap2
	{
		if key_up && FINAL_GAMEPLAY && state != states.jump
		{
			// Breakdance up
			if character != "S" && character != "V"
			{
				fmod_play_instance(suplexdashsnd);
				
				state = states.punch;
				image_index = 0;
				sprite_index = spr_breakdanceuppercut;
				vsp = -14;
				movespeed = hsp;
				instance_create(x, y, obj_highjumpcloud2);
				//instance_create(x, y, obj_swingdinghitbox);
				exit;
			}
		}
	}
	
	scr_player_suplexmoves()

	scr_shootandchainsaw();
	
	//Jetpack flash
	if character == "N" && (pogochargeactive)
	{
		if key_attack2
		{
			scr_soundeffect(sfx_noisewoah)
			state = states.Sjumpprep
			image_index = 0
			if !key_up
				sprite_index = spr_playerN_jetpackstart
			else
				sprite_index = spr_superjumpprep
			hsp = 0
			vsp = 0
		}
	}

	//Spin attack
	//if key_slap2 && character = "N" && !key_attack
	//{
	//	scr_soundeffect(sfx_Nspin)
	//		scr_soundeffect(sfx_suplexdash)
	//state = states.punch
	//sprite_index=  spr_playerN_spin
	//image_index = 0
	//movespeed = 15
	//}

	//Mach1
	if key_attack && !scr_solidwall(x + xscale, y) && !scr_solid_slope(x + xscale, y) 
	&& !(place_meeting(x + xscale, y, obj_slope) && scr_solidwall(x, y - 1)) 
	&& (!(character == "N" && noisetype == 0) && character != "S") && sprite_index != spr_shotgunshoot
	{
		if movespeed < 6 or OLD_GAMEPLAY
			movespeed = 6
		sprite_index = spr_mach1
		jumpAnim = true
		state = OLD_GAMEPLAY ? states.mach1 : states.mach2
		image_index = 0
	}
	
	//Pogo
	if key_attack && (character == "N" && noisetype == 0) 
	&& state != states.Sjumpprep && !key_slap2
	{
		sprite_index = spr_playerN_pogostart
		if character == "SP"
			sprite_index = spr_playerSP_canefall
		image_index = 0
		state = states.pogo
	}
	
	//Snick walk
	if character == "S" && move != 0 && !scr_solidwall(x + xscale, y)
	{
		movespeed = 6
		sprite_index = spr_mach1
		jumpAnim = true
		state = states.mach1
		image_index = 0
	}

	//Vigilante Dynamite
	if key_shoot2 && character = "V" && !instance_exists(obj_dynamite)
	{
		if move = 0
			movespeed = 0
		state = states.dynamite
		image_index = 0
		sprite_index = spr_playerV_dynamitethrow
		with instance_create(x,y,obj_dynamite)
		{
			image_xscale = other.xscale
			movespeed = 6
			vsp = -6
		}
	}

	//Vigilante revolver
	if key_slap2 && character = "V"
	{
		if move = 0
			movespeed = 0
		state = states.revolver	
		image_index = 0
		sprite_index = spr_playerV_revolverstart
	}

	////Shoot gun
	//if key_shoot2 && !key_up 
	//{

	//sprite_index =spr_player_pistol
	//state = states.pistol
	//image_index = 0
	//shoot = true
	//}
	//else
	////Aim gun
	//if key_up && key_shoot2 && move = 0
	//{

	//sprite_index =spr_player_shootup
	//state = states.pistol
	//image_index = 0
	//shoot = true
	//}
	//else if key_up && key_shoot2 && move != 0
	//{

	//sprite_index =spr_player_shootdiagonal
	//state = states.pistol
	//image_index = 0
	//shoot = true
	//}
	
	   //Hookshot 
	//if key_slap2 && character = "N" 
	//{
	//image_index = 0
	//sprite_index = spr_playerN_hookshot1
	//state = states.hookshot

	//with instance_create(x,y + 10,obj_hookshot) 
	//{

	//hsp = other.xscale * 30
	//}

	//}

	//Effects
	var step1 = 3;
	var step2 = 9;
	if character == "SP"
	{
		step1 = 1;
		step2 = 5;
	}

	if (move != 0 && (floor(image_index) == step1 || floor(image_index) == step2) 
	&& !steppy && character != "V")
	{
		if scr_checkskin(checkskin.p_anton)
		{
			var stepsnd = scr_soundeffect(sfx_antonstep1, sfx_antonstep2, sfx_antonstep3);
			if character == "SP"
				fmod_set_pitch(stepsnd, 1.5);
		}
		else if (FINAL_GAMEPLAY)
		{
			scr_soundeffect(_sfx_step)
		}
		instance_create(x, y + 43, obj_cloudeffect)
		steppy = true
	}

	if move != 0 && floor(image_index) != step1 && floor(image_index) != step2
		steppy = false
	
	// noise dab
	if global.cont > -1 && gamepad_button_value(global.cont, gp_shoulderlb) != 0 
	&& OLD_GAMEPLAY
	{
		image_index = 0;
		state = states.backbreaker;
		sprite_index = spr_playerN_dab;
	}
	
	//Taunt
	if key_taunt2 
		scr_player_taunt();
	
	if sprite_index == spr_shotgunshoot
	{
		landAnim = false;
		machslideAnim = false;
		image_speed = 0.45;
	}
	
}