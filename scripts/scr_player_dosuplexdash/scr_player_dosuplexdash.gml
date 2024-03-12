enum attacks
{
	grab,
	kungfu
}

enum doubleattacks
{
	none,
	faceplant,
	shoulderbash
}

function scr_player_dosuplexdash(move = global.attackstyle, doublemove = global.dattackstyle, 
prestate = state)
{
	if !grounded && character == "SP" && pizzymidairgrab > 1
		exit;
	if grounded
		pizzymidairgrab = 0
	
	grav = basegrav;
	
	#region move
	if prestate != states.handstandjump && prestate != states.kungfu
	{
		switch move
		{
			#region grab
			case attacks.grab:
				suplexmove = true
				if character != "SP" or FINAL_GAMEPLAY
					fmod_play_instance(suplexdashsnd);
				else
					scr_soundeffect(sfx_suplexdashSP);
				if !(scr_pizzyphys_check() && state == states.jump && vsp < 0 && OLD_GAMEPLAY)
				{
					if !grounded && !scr_pizzyphys_check()
						sprite_index = spr_suplexdashjumpstart
					else if !shotgunAnim
						sprite_index = spr_suplexdash
					else
						sprite_index = spr_shotgunsuplexdash
			
					state = states.handstandjump;
					movespeed = max(movespeed, 10);
					image_index = 0;
		
					if !grounded && scr_pizzyphys_check()
						pizzymidairgrab++
					else
						pizzymidairgrab = 0
			
					if REMIX_GAMEPLAY
					{
						if grounded
						{
							with instance_create(x, y, obj_crazyrunothereffect)
								image_xscale = other.xscale;
							with instance_create(x + (xscale * -50), y, obj_superdashcloud)
								image_xscale = other.xscale;
						}
					}
				}
				else
				{
					input_buffer_jump = 0
					instance_create(x, y, obj_jumpdust)
					state = states.mach2
					vsp = -11
				}
				break;
			#endregion
			#region kungfu
			case attacks.kungfu:
				suplexmove = true
				scr_soundeffect(sfx_kungfu);
				state = states.kungfu
				movespeed = max(movespeed, 10)
				image_index = 0
				image_speed = 0.35
				if grounded && vsp > 0
					sprite_index = choose(spr_kungfu1, spr_kungfu2, spr_kungfu3)
				else
					sprite_index = choose(spr_kungfuair1transition, 
					spr_kungfuair2transition, spr_kungfuair3transition)
				break;
			#endregion
		}		
	}
	#endregion
	else
	#region double attack
	{
		switch doublemove
		{
			#region shoulderbash
			case doubleattacks.shoulderbash:
				state = states.handstandjump
				if sprite_index != spr_attackdash 
				&& sprite_index != spr_airattack && sprite_index != spr_airattackstart 
				{
					scr_soundeffect(sfx_suplexdashSP);
					image_index = 0;
			
					with instance_create(x, y, obj_crazyrunothereffect)
						image_xscale = other.xscale;
			
					if grounded
					{
						sprite_index = spr_attackdash;
						with instance_create(x + (xscale * -50), y, obj_superdashcloud)
							image_xscale = other.xscale;
					}
					else
					{
						if vsp > -4
							vsp = -4;
						sprite_index = spr_airattackstart;
					}
				}
				break;
			#endregion
			#region faceplant
			case doubleattacks.faceplant:
				if faceplantbuffer > 0	
					break;
				image_index = 0
				sprite_index = spr_faceplant
				movespeed += 2.5
				state = states.faceplant
				image_speed = 0.5
				with instance_create(x, y, obj_jumpdust)
					image_xscale = other.xscale
			
				with instance_create(x, y, obj_crazyrunothereffect)
				{
					playerid = other.object_index	
					other.crazyruneffectid = id
				}
				break;
			#endregion
		}
	}
	#endregion
}

function scr_player_suplexmoves()
{
	if character != "S" && character != "V" && !suplexmove
	{
		if key_slap2
			scr_player_dosuplexdash()
		if key_extra2 && global.attackstyle != attacks.grab
			scr_player_dosuplexdash(attacks.grab)
	}
}