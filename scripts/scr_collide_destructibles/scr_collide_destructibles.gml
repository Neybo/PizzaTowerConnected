function scr_collide_destructibles()
{
	if character == "V" && OLD_GAMEPLAY
		return;
	
	if (state == states.jump && sprite_index == spr_playerN_noisebombspinjump)
	or (state == states.pogo && pogochargeactive)
	or (state == states.knightpep && FINAL_GAMEPLAY)
	or state == states.slipbanan or state == states.tumble
	{
		with instance_place(x + hsp + xscale, y, obj_destructibles)
		{
			gp_vibration(0.8, 0.8, 0.5);
			momentum[0] = other.hsp;
			instance_destroy();
		}
			
		if state == states.tumble
			with instance_place(x, y - 4, obj_destructibles) 
			{
				gp_vibration(0.8, 0.8, 0.5);
				momentum[1] = other.vsp;
				instance_destroy();
			}
		else
		{
			with instance_place(x, y + vsp - 1, obj_destructibles)
			{
				gp_vibration(0.8, 0.8, 0.5);
				momentum[1] = other.vsp;
				instance_destroy();
			}
			
			with instance_place(x, y + vsp + 1, obj_destructibles) 
			{
				gp_vibration(0.8, 0.8, 0.5);
				momentum[1] = other.vsp;
				instance_destroy();
			}
		}
	}
		
	// Destroy Destructibles
	if place_meeting(x + hsp, y, obj_destructibles)
	{
		if state == states.handstandjump or state == states.mach2 or state == states.mach3
		or state == states.faceplant or state == states.rideweenie or state == states.tacklecharge
		or state == states.machroll or state == states.knightpepslopes// or state == states.tumble
		or state == states.hookshot or state == states.crouchslide or state == states.cheeseball
		or state == states.rocket or state == states.kungfu
		or (state == states.barrel && sprite_index == spr_barrelroll)
		or (state == states.punch && sprite_index != spr_breakdanceuppercut)
		or (state == states.firemouth && FINAL_GAMEPLAY)
		or (state == states.grab && sprite_index == spr_swingding)
		or (state == states.cotton && (sprite_index == spr_cotton_attack or movespeed > 6))
		or state == states.chainsaw or state == states.newweenieriding
		or state == states.supersidejump or state == states.dogmount or state == states.dogmountspin
		{
			var _y = y
			with instance_place(x + hsp, _y, obj_destructibles)
			{
				if REMIX_GAMEPLAY
					momentum[0] = other.hsp;
				if inst_relation(self, obj_bigdestructibles) && (other.state == states.handstandjump 
				or (other.state == states.mach2 && hp > 1))
				{
					// grab on big blocks
					if hp > 1 or OLD_GAMEPLAY
					{
						with other
						{
							suplexmove = false;
							scr_pummel();
						}
					}
						
					hp--;
					if hp <= 0
						instance_destroy();
					else
						event_user(0);
				}
				else
					instance_destroy();
				gp_vibration(0.8, 0.8, 0.5);
			}
				
			if state == states.mach2
				machpunchAnim = true;
		}
	}
		
	// Destroy thrown
	if state == states.hurt && thrown
	{
		with instance_place(x - hsp, y, obj_destructibles)
			instance_destroy();
	}

	// Destroy from over
	if (state == states.knightpep or state == states.superslam or state == states.hookshot 
	or (state == states.cotton && sprite_index == spr_cotton_drill)) && vsp >= 0
	{
		with instance_place(x, y + 1, obj_destructibles)
		{
			gp_vibration(0.8, 0.8, 0.5);
			instance_destroy();
			momentum[1] = other.vsp;
		}
	}
		
	// Destroy from under
	if (vsp <= grav or state == states.Sjump) && (state == states.jump or state == states.pogo 
	or state == states.climbwall or state == states.fireass or state == states.Sjump 
	or state == states.mach1 or state == states.mach2 or state == states.mach3 or state == states.punch)
	{
		var checker = -1;
		if state == states.punch && sprite_index == spr_breakdanceuppercut
			checker = vsp;
			
		var block = instance_place(x, y + checker, obj_destructibles);
		if block
		{
			if state == states.Sjump
				vsp = -11;
				
			with block
			{
				gp_vibration(0.8, 0.8, 0.5);
				instance_destroy();
				momentum[1] = other.vsp;
			}
				
			if state != states.Sjump && state != states.climbwall && (state != states.punch 
			|| OLD_GAMEPLAY)
				vsp = 0;
		}
	}

	if vsp >= 0 
	{
		// Freefall destroy
		if (state == states.freefall or state == states.freefallland)
		{
			var block = instance_place(x, y + vsp + 2, obj_destructibles);
			/*if block
			{
				with block
					if place_meeting(x, y, obj_platform) block = false;
			}*/
			if block
			{
				if inst_relation(block, obj_bigdestructibles)
				&& (freefallsmash <= 10 or OLD_GAMEPLAY)
				{
					if !shotgunAnim
						sprite_index = spr_bodyslamland
					else
						sprite_index = spr_shotgunjump2
					state = states.freefallland
					image_index = 0
				}
				
				with block
				{
					gp_vibration(0.8, 0.8, 0.5);
					momentum[1] = other.vsp;
					instance_destroy();
				}
			}
		}
		
		// break rat from above
		if sprite_index == spr_cotton_drill
		{
			with instance_place(x, y + vsp, obj_ratblock)
		        instance_destroy()
		}
	}
	
	

	// Superslam destroy metal
	if state == states.freefallland
	{
		if place_meeting(x, y + 1, obj_metalblock) && freefallsmash >= 10
		{
			with instance_place(x, y + 1, obj_metalblock)
			{
				momentum[1] = other.vsp;
				instance_destroy();
			}
		}
	}
	
	// Superjump destroy metal
	if state == states.Sjump && (springsjump or check_sugary())
	{
		if place_meeting(x, y - 1, obj_metalblock)
		{
			with instance_place(x, y - 1, obj_metalblock)
			{
				momentum[1] = other.vsp;
				instance_destroy();
			}
		}
	}
	
	// Cheese platforms
	if floor(hsp) == 0
	{
		with obj_destructibleplatform
		{
			if place_meeting(x, y - 1, other)
			{
				if !falling
				{
					falling = true;
					sprite_index = spr_dissolve;
					image_index = 0;
				}
			}
		}
	}
	
	// Destroy tnt block
	if  ((state == states.firemouth && FINAL_GAMEPLAY) 
	or (state == states.handstandjump && OLD_GAMEPLAY))
	{
		var block = instance_place(x + hsp, y, obj_tntblock);
		if block
		{
			with block
			{
				if REMIX_GAMEPLAY
					momentum[0] = other.hsp;
				instance_destroy();
			}
		}
	}
		
	// Roll blocks
	if (state == states.tumble or (sprite_index == spr_snick_tumble && 
	(state == states.mach2 or state == states.mach3)))
	{
		var place = instance_place(x + hsp, y, obj_rollblock)
		if !place
			return;
		with place
		{
			if REMIX_GAMEPLAY
				momentum[0] = other.hsp;
			instance_destroy();
		}
	}
}
