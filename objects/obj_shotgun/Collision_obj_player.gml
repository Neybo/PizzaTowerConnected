if other.character != "S" && other.character != "V"
{
	if !other.shotgunAnim && !other.backupweapon && other.state == states.handstandjump
	{
		with other
		{
			shotgunAnim = true
			state = states.shotgun
			image_index = 0
			sprite_index = spr_shotgunpullout
		}
		
		global.gotshotgun = true
		scr_soundeffect(sfx_shotgungot)
		if room == war_1
		{
			if !global.funmode
			{
				with (instance_create_unique(0, 0, obj_wartimer))
		        {
		            minutes = 0
		            seconds = 40
		        }
				
				fmod_stop_instance_immediately(global.music);
				scr_sound((global.musicgame) ? mu_war_pc : mu_war)
			}
			else
			{
				fmod_stop_instance_immediately(global.music);
				scr_sound((global.musicgame) ? mu_warfull_pc : mu_warfull);	
			}
		}
		instance_destroy()
		
		tv_push_prompt_once(tv_create_prompt("This is the shotgun powerup text", 2, spr_tv_shotgun, 3), "shotgun");
		global.heattime = 60;
		
		with obj_tv
		{
			image_speed = 0.25
			message = choose("ITS TIME TO KICK ASS", "ITS TIME TO ASS", "ITS TIME TO CHEW ASS", "ITS TIME TO KICK GUM")
			alarm[0] = 200
			showtext = true
			tvsprite = spr_tvdook
		}
	}
}

