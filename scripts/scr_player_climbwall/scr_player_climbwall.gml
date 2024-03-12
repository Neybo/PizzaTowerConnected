function scr_player_climbwall()
{
	switch character
	{
		default:
		if character != "N" or noisetype == 1
		{
			pizzymidairgrab = 0
			
			if windingAnim < 2000 && character == "P"
				windingAnim++
			
			move = key_left + key_right;

			suplexmove = false
			
			hsp = 0
			vsp = -wallspeed + (place_meeting(x + xscale, y, obj_railv) * -3);
			
			if place_meeting(x + xscale, y, obj_unclimbablewall)
			or place_meeting(x, y, obj_stickycheese)
			or place_meeting(x, y, obj_molasseswall)
			{
				wallspeed = max(wallspeed - grav / 2, -1.5);
				if wallspeed > 6
					wallspeed = 6;
				
				if OLD_GAMEPLAY
				{
					if wallspeed <= 0
					{
						state = states.jump
						sprite_index = spr_fall
						exit;
					}
					if sprite_index != spr_machclimbwall && wallspeed < 8
						wallspeed = 8;
				}
				else if grounded
				{
					state = states.normal
					movespeed = 0
				}
				
				var mv = wallspeed / 16;
				image_speed = lerp(0.35, 0.75, mv); // limit to 2 decimal places
			}
			else
			{
				if OLD_GAMEPLAY
				{
					if wallspeed < 24 && move == xscale
						wallspeed += 0.05;
					if wallspeed < 8
						wallspeed = 8;
				}
				else
				{
					if wallspeed < spd_turnmach4
						wallspeed += spd_wallclimb1
					else
						wallspeed += spd_wallclimb2
				}
				
				wallspeed = min(20, wallspeed)
				image_speed = 0.6;
			}
			if scr_solid(x, y + 1) && wallspeed < 0
				wallspeed = 0;
			
			crouchslideAnim = true

			//Animations
			sprite_index = spr_machclimbwall

			//Back to other states
			if (!key_attack && wallclimbbuffer <= 0 && character != "S") or (character == "S" && move == 0)
			{
				state = states.normal
				pizzymidairgrab = 0
				movespeed = 0
				
				if FINAL_GAMEPLAY
				{
					railmovespeed = 6
					raildir = -xscale
				}
			}
			wallclimbbuffer--; 
			
			// back to ground
			if !scr_solidwall(x + xscale, y) && !scr_solid_slope(x + xscale, y) 
			&& state == states.climbwall
			{
				if vsp < 0
				{
					for(var i = 0; i < 32; i++)
					{
						if scr_solid(x + xscale, y + i + 1)
						{
							y += i;
							break;
						}
					}
					vsp = 0
				}
				if instance_place(x + xscale, y, obj_solid)
					return; // fuck you you're wrong cunt
				
				with instance_create(x, y, obj_jumpdust)
					image_xscale = other.xscale
				
				if wallspeed >= 12
				{
					sprite_index = spr_mach4
					state = states.mach3
				}
				else
				{
					sprite_index = spr_mach
					state = states.mach2
				}
				grounded = false // eat shit
				
				if global.oggamespeed && wallspeed < 6
					wallspeed = 6
				else if !global.oggamespeed
					movespeed = min(max(wallspeed * 1.1, 6), 20);
				
				hsp = movespeed * xscale
			}
			
			//Hit head
			if (scr_solidwall(x, y - 1) && !place_meeting(x, y - 1, obj_destructibles) 
			or place_meeting(x, y - 1, obj_slope)) && state == states.climbwall
			{
				image_speed = 0.6;
				with obj_camera
				{
					shake_mag = 3;
					shake_mag_acc = 4 / room_speed;
				}
				
				if character == "SP"
				{
					sprite_index = spr_playerSP_hitceiling
					if FINAL_GAMEPLAY
						sprite_index = spr_playerSP_hitceiling_NEW
				}
				else
					sprite_index = spr_superjumpland
				
				groundpoundsnd = scr_soundeffect(sfx_groundpound)
				image_index = 0
				state = states.Sjumpland
				machhitAnim = false
			}
			
			//Jump
			if key_jump
			{
				if scr_pizzyphys_check() && abs(wallspeed) >= 12
				{
					if wallspeed >= 20 && !global.infspeed
						movespeed = abs(wallspeed) - 0.1;
					instance_create(x, y, obj_jumpdust);
					sprite_index = spr_mach4;
					state = states.mach3;
				}
				else if scr_pizzyphys_check() && key_down
				{
					state = states.machroll
					vsp = 10
				}
				else
				{
					if global.slopebitch
					{
						if OLD_GAMEPLAY
							movespeed = 8;
						else
							movespeed = 10;
					}
					else if global.oggamespeed
						movespeed = 10
					else
						movespeed = max(wallspeed / 1.25, 10);
					state = states.mach2;
					image_index = 0;
					
					sprite_index = spr_walljumpstart;
				}
				
				vsp = (scr_pizzyphys_check() ? -9 : -11);
				xscale *= -1
				jumpstop = false
			}
			
			if !instance_exists(obj_cloudeffect)
				instance_create(x, y + 43, obj_cloudeffect)
		}
		else
		{
			hsp = 0
			if sprite_index = spr_playerN_wallclingstart && floor(image_index) >= image_number - 1
				sprite_index = spr_playerN_wallcling

			if sprite_index = spr_playerN_wallcling
				vsp = 2
			else
				vsp = 0

			wallclingcooldown = 0

			if floor(image_index) >= image_number - 1 or !key_jump2
			{
				vsp = -15
				state = states.jump
				sprite_index = spr_playerN_jump
				image_index = 0
			}

			if key_jump
			{
				vsp = -15
				state = states.jump
				sprite_index = spr_playerN_jump
				image_index = 0
			}
			image_speed = 0.35;
		}
		break
	}
}