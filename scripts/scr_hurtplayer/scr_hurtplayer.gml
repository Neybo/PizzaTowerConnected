function scr_hurtplayer(pid = obj_player, loseamount = 50)
{
	loseamount *= global.stylethreshold + 1;
	with pid
	{
		// Auto parry
		if ((spr_crazyrun == sprite_index && state == states.mach3) 
		or (state == states.grab && sprite_index == spr_swingding))
		&& (character != "S" && character != "V" && REMIX_GAMEPLAY)
		{
			// kill baddie if grabbing
			if state == states.grab
			{
				with obj_baddie
				{
					if state == states.grabbed && grabbedby > -1 && parryable
					&& object_index != obj_pizzaballOLD
						instance_destroy();
				}
			}
			
			if !instance_exists(parry_inst)
				parry_inst = instance_create(x, y, obj_parryhitbox);
		}
		
		//Knight armor remove
		if (state == states.knightpep or state == states.knightpepattack or state == states.knightpepslopes) && !cutscene
		{

		}
		
		// custom
		else if godmode or state == states.parry or state == states.taxi or state == states.actor 
		or state == states.backbreaker or state == states.bump or state == states.firemouth 
		or state == states.barrel or state == states.hitlag or state == states.rotate 
		or state == states.frozen or state == states.door or state == states.victory
		or state == states.keyget or (state == states.fireass && FINAL_GAMEPLAY) 
		or instance_exists(obj_parryhitbox)
		{
		
		}
	
		//Ghost
		
		else if state == states.ghost
		{
	
   
		}
		//Bomb!!
		else if state == states.bombpep && !hurted
		{
	
   
		}
	
		//Weenie ride
		else if state == states.rideweenie
		{
	
   
		}
		
		//Boxxed
		else if state == states.boxxedpep
			scr_transfobump();
	
		// cheeseball
		else if state == states.cheeseball
		{
			scr_soundeffect(sfx_loseknight)
			grav = basegrav
		
			repeat 9
				instance_create(x, y, obj_slimedebris) 
			
			hsp = xscale * -5;
			vsp = -3
		
			image_index = 0
			flash = true
			state = states.bump
		
			alarm[5] = 2
			alarm[7] = 60
			hurted = true
		}
	
		//Cheesed
	
		else if (state == states.cheesepep or state == states.cheesepepstick) 
		{
	
		
		}

		//Pizza Shield
		else if pizzashield
		{
			pizzashield = false
			with instance_create(x, y, obj_sausageman_dead)
				sprite_index = spr_pizzashield_collectible
			hsp = -xscale * 4
			vsp = -5
			state =states.bump
			sprite_index = spr_bump
			
			alarm[8] = 60
			alarm[7] = 120
			hurted = true
			scr_soundeffect(sfx_pephurt)
		}
		
		
		//Hurt
		else if state != states.grabbed && !cutscene && invhurt_buffer <= 0
		&& ((state != states.hurt && !hurted)/* or FINAL_GAMEPLAY*/)
		{
			scr_transfobump(false);
			if hurt_buffer == -1 && FINAL_GAMEPLAY
				hurt_buffer = hurt_max;
			
			//Pizza delivery HP
			if global.pizzadelivery
			{
				with instance_create(x, y, obj_debris)
					sprite_index = spr_healthpickupeaten;
				
				global.hp -= 1;
				if global.hp > 0
				{
					with obj_camera
						healthshaketime = 20;
				}
				else
				{
					with obj_music
						arena = false;
		
					vsp = -20;
					global.hp = 0;
					global.pizzadelivery = false;
					cutscene = true;
		
					with instance_create(0, 0, obj_cutscene_handler)
					{
						var player = other.id
						scene_info = 
						[
							[cutscene_taxi_start, player], 
							[cutscene_waitfor_sprite, player], 
							[cutscene_set_sprite, player, spr_player_outofpizza2, 0.5, player.xscale], 
							[cutscene_player_check_ground, player], 
							[cutscene_set_sprite, player, spr_player_outofpizza3, 0.5, player.xscale], 
							[cutscene_waitfor_sprite, player], 
							[cutscene_set_sprite, player, spr_player_outofpizza4, 0.35, player.xscale], 
							[cutscene_taxi_end, player, forest_4]
						]
					}
				}
			}
			if character == "V"
				global.playerhealth -= 25
				
			if state == states.mort
			{
				with instance_create(x, y, obj_sausageman_dead)
					sprite_index = spr_mortdead
				repeat 6 with instance_create(x, y, obj_debris)
					sprite_index = spr_feather
				grav = basegrav
			}
			scr_soundeffect(sfx_pephurt)
			if FINAL_GAMEPLAY
			{
				if character == "P"
					scr_soundeffect(sfx_pephurtvoice)
				else if character == "N"
					scr_soundeffect(sfx_noisehurt)
				else if character == "V"
					scr_soundeffect(sfx_vigihurt)
			}
			if (global.notgonnasugarcoatit)
				instance_create(0,0,obj_sugarcoated)
			
			alarm[8] = 100
			alarm[7] = OLD_GAMEPLAY ? 30 : 50
			
			if xscale = other.image_xscale
				sprite_index = spr_hurtjump
			else
				sprite_index = spr_hurt
			
			movespeed = OLD_GAMEPLAY ? 12 : 8
			vsp = OLD_GAMEPLAY ? -5 : -14
			timeuntilhpback = 300
			
			if OLD_GAMEPLAY
			{
				alarm[8] = 60
				alarm[7] = 120
				movespeed = 8
				
				if character == "S"
				{
					if global.collect == 0
					{
						state = states.gameover
						sprite_index = spr_deathstart
						exit
					}
					else
					{
						repeat min(global.collect / 10, ceil(loseamount / 2))
							instance_create(x, y, obj_pizzaloss_recollect);
						global.collect = 0;
					}
				}
			}
			
			instance_create(x, y, obj_spikehurteffect)
			state = states.hurt
			image_index = 0
			flash = true
			
			if character == "SP" && OLD_GAMEPLAY
			{
				repeat 5 with instance_create(x, y, obj_slapstar)
				{
					sprite_index = spr_slapstar_ss;
					image_index = irandom_range(0, image_number - 1);
					hsp = random_range(-10, 10);
					angspd = random(2);
				}
			}
			
			if !global.pizzadelivery or OLD_GAMEPLAY
			{
				if !(global.snickchallenge && shotgunAnim)
				{
					if character != "SP" or FINAL_GAMEPLAY
						repeat (min(global.collect / 10, ceil(loseamount / 5))) instance_create(x, y, obj_pizzaloss);
					
					if !hurted
					{
						global.hurtcounter += 1;
						global.collect = max(global.collect - loseamount, 0);
						
						with instance_create(x, y, obj_smallnumber)
						{
							negative = 1
							number = string(-loseamount)
						}
					}
				}
				else
				{
					with instance_create(x, y, obj_sausageman_dead)
						sprite_index = spr_shotgunback;
					shotgunAnim = false;
				}
			}
			
			hurted = true;
			
			invhurt_buffer = 10;
			global.combotime -= 25
			global.style -= 25
	        global.hurtcounter += 1
			
			return true;
		}
	}
	return false;
}

function scr_hurtplayer_weak(pid)
{
	if is_undefined(pid)
		pid = obj_player;
	if argument_count > 1
		var m = argument[1];
	else
		m = true;
	
	with pid
	{
		if state == states.parry
		{
			
		}
		else if !hurted
		{
			if state == states.grabbed
				gms_p2p_send(p2p.pvp_stopgrab, grabbedby);
			
			scr_soundeffect(sfx_pephurt);
			thrown = true;
			
			repeat 3
			{
				with instance_create(x, y, obj_slapstar)
					gms_instance_sync(id, is_onetime | isc_local);
			}
			with obj_camera
			{
				shake_mag = 3;
				shake_mag_acc = 0.05;
			}
		
			state = states.hurt

			if (global.notgonnasugarcoatit)
				instance_create(0,0,obj_sugarcoated)

			alarm[8] = 60
			alarm[7] = 120
			
			if m
			{
				movespeed = 15
				vsp = -6
				xscale = -other.image_xscale;
			
				sprite_index = spr_hurt;
			}
			//if (global.hp > 0 && !global.pizzadelivery)
			//	global.hp -= 1
		}
	}
}