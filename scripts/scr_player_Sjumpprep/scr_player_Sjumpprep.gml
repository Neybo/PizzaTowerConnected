function scr_player_Sjumpprep() {

	switch character
	{
		default:
		if character != "N" or (character == "N" && noisetype == 1)
		{
			combo = 0
			mach2 = 0
		
			if (sprite_index == spr_superjumppreplight or sprite_index == spr_superjumpright 
			or sprite_index == spr_superjumpleft)
			or OLD_GAMEPLAY
				move = key_left + key_right;
			else
				move = xscale;
			
			if OLD_GAMEPLAY
			{
				if sprite_index == spr_superjumppreplight or sprite_index = spr_snick_superjumplight 
				or sprite_index = spr_superjumpright or sprite_index = spr_superjumpleft
				{
					var railh = 0, railmeet = instance_place(x, y + 1, obj_railparent);
					if railmeet then railh = railmeet.spdh;
					hsp = move * 2 + railh;
				}
				
				if sprite_index == spr_superjumpprep
				{
					var railh = 0, railmeet = instance_place(x, y + 1, obj_railparent);
					if railmeet then railh = railmeet.spdh;
					hsp = xscale * movespeed + railh;
					
					if movespeed > 0
						movespeed -= 0.8
				}
			}
			else
			{
				var railh = 0, railmeet = instance_place(x, y + 1, obj_railparent);
				if railmeet then railh = railmeet.spdh;
				hsp = move * movespeed + railh;
				
				if sprite_index == spr_superjumpprep && movespeed > 0
					movespeed -= 1;
			}
		
			if floor(image_index) >= image_number - 1 && sprite_index == spr_superjumpprep 
				sprite_index = spr_superjumppreplight
		
			if sprite_index == spr_superjumppreplight
			{
				movespeed = 1;
				if FINAL_GAMEPLAY
					movespeed = 2; // lil' speed up why not - because it's better and more like final game pizza tower!
			}
			
			if character == "S"
			{
				if floor(image_index) >= image_number - 1 && sprite_index == spr_snick_superjumpprep
					sprite_index = spr_snick_superjumplight
				if move != 0
					xscale = move
			}
			else
			{
				if sprite_index != spr_superjumpprep
				{
					if sign(hsp) == 0
						sprite_index = spr_superjumppreplight
					else
					{
						if sign(hsp) == xscale
							sprite_index = spr_superjumpright
						else
							sprite_index = spr_superjumpleft
					}
				}
			}
		
			if OLD_GAMEPLAY
			{
				start_running = true
				alarm[4] = 14
			
				jumpAnim = true
				dashAnim = true
				landAnim = false
				machslideAnim = true
				moveAnim = true
				stopAnim = true
				crouchslideAnim = true
				crouchAnim = true
			}

			if !key_up && (grounded or 
			(character == "S" && OLD_GAMEPLAY) or 
			(scr_pizzyphys_check() && sjump))
			&& (character == "S" or ((sprite_index == spr_superjumppreplight 
			|| (REMIX_GAMEPLAY && global.instantsjumpcancel)) 
			or sprite_index == spr_superjumpleft or sprite_index == spr_superjumpright)) 
			&& (!scr_solid(x, y - 32) or place_meeting(x, y - 32, obj_destructibles))
			{
				superjumpreleasesnd = scr_soundeffect(sfx_superjumprelease)
				instance_create(x, y, obj_explosioneffect)
				sprite_index = spr_superjump
				state = states.Sjump
				vsp = -17
				image_index = 0
			}
			image_speed = 0.35
		}
		
		if character == "N" && noisetype == 0
		{
			hsp = 0
			vsp = 0
			
			pogochargeactive = false
			pogocharge = 50
			
			if floor(image_index) >= image_number - 1
			{
				if sprite_index == spr_playerN_jetpackstart
				{
						state = states.mach3
						sprite_index = spr_playerN_jetpackboost
						instance_create(x, y, obj_jumpdust)
						movespeed = 15
				}
				else if sprite_index == spr_superjumpprep
				{
					superjumpreleasesnd = scr_soundeffect(sfx_superjumprelease)
					instance_create(x, y, obj_explosioneffect)
					sprite_index = spr_superjump
					state = states.Sjump
					vsp = -15
				}
			}
			
			if sprite_index == spr_playerN_jetpackstart
				image_speed = 0.5
			else
				image_speed = 0.35
		}
		break;
	}
	if !fmod_is_instance_playing(superjumpholdsnd) && !fmod_is_instance_playing(sjumpprepsnd)
		fmod_play_instance(superjumpholdsnd)
}

