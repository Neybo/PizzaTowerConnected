function scr_player_punch()
{
	if sprite_index == spr_punch
	{
		move = key_left + key_right;
		if grounded
		{
			//Turn
			if dir != xscale
			{
				dir = xscale
				movespeed = 2 
				facehurt = false
			}
			jumpstop = false
			anger = 100
			
			var railh = 0, railmeet = instance_place(x, y + 1, obj_railparent);
			if railmeet then railh = railmeet.spdh;
			hsp = move * movespeed + railh;
			
			//Movespeed
			if move != 0 
			{
				if movespeed < 7
					movespeed += 0.5
				else if floor(movespeed) == 7 
					movespeed = 7
			}
			else
				movespeed = 0

			if movespeed > 7
				movespeed -= 0.1
			
			if move != 0
			{
				if movespeed < 3 && move != 0
					image_speed = 0.35
				else if movespeed > 3 && movespeed < 6 
					image_speed = 0.45
				else
					image_speed = 0.6
			}
			else 
				image_speed = 0.35
		}
		
		if !grounded
		{
			if !momentum
				hsp = move * movespeed;
			else
				hsp = xscale * movespeed

			if move != xscale && momentum && movespeed != 0 
				movespeed -= 0.05

			if movespeed <= 0
				momentum = false
			
			if move == 0 && !momentum or scr_solid(x + hsp, y)
			{
				movespeed = 0
				mach2 = 0
			}
			if move != 0 && movespeed < 7
				movespeed += 0.25
			if movespeed > 7 
				movespeed -= 0.05

			if scr_solid(x + move, y)
				movespeed = 0

			//Turn
			if dir != xscale 
			{
				mach2 = 0
				dir = xscale
				movespeed = 0 
			}
			if move == -xscale
			{
				mach2 = 0
				movespeed = 0 
				momentum = false
			}
			landAnim = false
			
			//Jump Stop
			if !key_jump2 && !jumpstop && vsp < 0.5
			{
				vsp /= 5
				jumpstop = true
			}
			
			//Hit head
			if scr_solid(x, y - 1) && !jumpstop && jumpAnim
			{
				vsp = grav
				jumpstop = true
			}
		}
		jumpAnim = true
		dashAnim = true
		landAnim = false
		moveAnim = true
		stopAnim = true
		crouchslideAnim = true
		crouchAnim = true
		
		if animEnd or move == -xscale
			state = states.normal
		
		//Animations
		sprite_index = spr_punch
		image_speed = 0.35
	}
	else
	{
		move = key_left + key_right
		jumpstop = false
		
		if sprite_index == spr_breakdanceuppercut or sprite_index == spr_breakdanceuppercutend
		{
			landAnim = true
			if move != 0
			{
				dir = move
				if (abs(movespeed) < 6 || global.slopebitch) // Eggplant/PTO Uppercut
				{
					movespeed = Approach(movespeed, 
					(move * (global.slopebitch ? 4 : 6)), 0.5)
				}
				if !global.slopebitch && REMIX_GAMEPLAY
				{
					if (move != sign(xscale))
					{
						movespeed -= 0.125 * movespeed;
					}
				}
			}
			hsp = movespeed;
			
			if animEnd && sprite_index == spr_breakdanceuppercut
				sprite_index = spr_breakdanceuppercutend
			if scr_solid(x + movespeed * xscale, y)
				movespeed = 0;
			if grounded && vsp >= 0
			{
				if hsp != 0
				{
					dir = sign(hsp);
					xscale = dir;
				}
				if global.slopebitch || NOT_REMIX_GAMEPLAY
				{
					movespeed = abs(movespeed);
					state = states.normal;
				}
				else
				{
					if move != sign(xscale)
					{
						movespeed = 0;
						state = states.normal;
					}
					else
					{
						movespeed = abs(movespeed);
						state = states.normal;
						return;
					}
				}
			}
			image_speed = 0.35
		}
		else if (sprite_index == spr_superjumpcancel)
		//or sprite_index == spr_superjumpcancelland or sprite_index == spr_superjumpcancelslide)
		{
			move = 0
			if move != 0
	              {
	                  if move != xscale && movespeed > -6
					movespeed -= 1
	              }
			
			/*if animEnd && (sprite_index == spr_superjumpcancelland)
			   {
					sprite_index = spr_superjumpcancelslide
			   }
			*/
			   
			if (!instance_exists(chargeeffectid))
				with instance_create(x,y,obj_chargeeffect)
				{
					playerid = other.object_index	
					other.chargeeffectid = id
					offsetx = 30
				}
			if key_down2 && scr_vigisnickcheck()
			{
				state = states.tumble
				sprite_index = spr_dive
				vsp = 10
			}
			scr_player_suplexmoves()
			
			hsp = xscale * movespeed
			if grounded && vsp > 0
                  {
				instance_destroy(chargeeffectid)
				movespeed = abs(movespeed)
                      if key_attack
                      {
                          if movespeed >= 12
                              state = states.mach3
                          else
                              state = states.mach2
					if move != 0
						xscale = move
                          sprite_index = spr_rollgetup
                          image_index = 0
                      }
                      else if movespeed > 6
                      {
					xscale = sign(hsp)
                          state = states.machslide
                          sprite_index = spr_machslidestart
                          image_index = 0
                      }
                      else
                          state = states.normal
                  }
			if ((sprite_index != spr_kungfujump 
			|| !global.slopebitch) && place_meeting(x + xscale, y, obj_solid) 
			&& !place_meeting(x + xscale, y, obj_destructibles) 
			&& !place_meeting(x + xscale, y, obj_slope))
	              {
				if (global.slopebitch)
				{
					vsp = -4
					sprite_index = spr_kungfujump
				    image_index = 0
				    movespeed = -6
				}
				else
				{
					wallspeed = 12
					wallclimbbuffer = 0
					state = states.climbwall
				}
	              }
		}
		else if sprite_index == spr_kungfujump
		{
			if move != 0
	              {
	                  if move != xscale && movespeed > -6
	                      movespeed -= 0.1
	                  else if move == xscale && movespeed < 6
	                      movespeed += 0.2
	              }
	              hsp = xscale * movespeed
			
			if grounded && vsp >= 0
                      state = states.normal
		}
		else
			hsp = xscale * movespeed
		
		if (sprite_index == spr_breakdance 
		|| sprite_index == spr_breakdancestart 
		|| sprite_index == spr_breakdancesuper
		|| sprite_index == spr_buttattack
		|| sprite_index == spr_buttattackstart
		|| sprite_index == spr_buttattackend)
			scr_breakdance_handle()
		
		if !instance_exists(obj_dashcloud2) && grounded && movespeed > 5
		{
			with instance_create(x, y, obj_dashcloud2)
				image_xscale = other.xscale
		}
	}
}
