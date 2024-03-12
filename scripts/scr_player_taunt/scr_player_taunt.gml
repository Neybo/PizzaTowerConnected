function scr_player_taunt()
{
	with (inst_relation(id, obj_player) ? id : obj_player)
	{
		if (!instance_exists(obj_fadeout) or obj_fadeout.fadein)
		{
			grav = basegrav;
			
			breakdancetime = 1
			taunttimer = 20
			tauntstoredmovespeed = movespeed
			tauntstoredsprite = sprite_index
			tauntstoredstate = state
			state = states.backbreaker
			
			sprite_index = spr_taunt
			image_index = irandom(sprite_get_number(sprite_index))
			
			if (supercharged || (OLD_GAMEPLAY && global.combo > 3)) 
			&& character != "V" 
			&& (key_up || OLD_GAMEPLAY)
			{
				if character == "SP"
					scr_soundeffect(sfx_supertaunt_SP)
				else if FINAL_GAMEPLAY
					scr_soundeffect(sfx_supertauntfinal)
				else
					scr_soundeffect(sfx_supertaunt)
				
				
				image_index = 0
				sprite_index = choose(spr_supertaunt1, spr_supertaunt2, spr_supertaunt3, spr_supertaunt4)
				
				// supertaunt kill
				if REMIX_GAMEPLAY
					global.combotime = min(global.combotime + 10, 60)
				vsp = 0
				supercharged = false;
				supercharge = 0;
				
				
				scr_baddie_screenclear();
				with obj_camera
				{
					shake_mag = 10;
					shake_mag_acc = 30 / room_speed;
				}
			}
			else
			{
			      var door = instance_place(x, y, obj_exitgate)
			      if door && global.panic
			         with door
					 {
						 if object_index != obj_exitgate
							return;
						 if global.tauntcount < 10
						 {
							 global.tauntcount++
							 global.collect += 25
						 }
					 }

				if character == "SP"
					tauntsnd = scr_soundeffect(sfx_tauntSP);
				else
					tauntsnd = scr_soundeffect(sfx_taunt);
				
				taunttimer = 20
				image_speed = 0
				
				if sprite_index == spr_player_taunt
				{
					// 11 = look right
					// 12 = look left
					if image_index == 11 && xscale == -1
						image_index = 12;
					else if image_index == 12 && xscale == 1
						image_index = 11;
				}
			}
			with instance_create(x, y, obj_taunteffect)
			{
				player = other.id;
				depth = other.depth + 1;
			}
		}
	}
}
