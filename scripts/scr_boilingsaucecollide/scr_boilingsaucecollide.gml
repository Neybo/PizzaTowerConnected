function scr_boilingsaucecollide(player = id){
	if player.character == "V" 
		scr_hurtplayer(player);
	else
	{
		//Burn player
		if player.state != states.gameover && player.state != states.rideweenie 
		&& player.state != states.hitlag
		{
			with player
				scr_transfobump(false);
			
			if player.state != states.fireass
				tv_push_prompt_once(tv_create_prompt("This is the fireass transformation text", 2, spr_tv_fireass, 3), "fireass");
			
			player.image_blend = c_white
			player.state = states.fireass
			player.sprite_index = player.spr_fireass
			player.image_index = 0
			with player
				event_perform(ev_step_begin, 0)
				
			player.sprite_index = player.spr_fireass

			
			if FINAL_GAMEPLAY
				player.movespeed = player.hsp
			
			player.vsp = -25
			player.vsp *= image_yscale == 0 ? 1 : sign(image_yscale);
			
			if !fmod_is_instance_playing(player.snd_fireass) 
			or fmod_get_instance_timeline_pos(player.snd_fireass) >= 5000
			{
				fmod_stop_instance_immediately(player.snd_fireass);
				fmod_play_instance(player.snd_fireass);
			}
			gp_vibration(1, 1, 0.85);
		}
	}
}

function scr_drillsaucecollide(player = id)
{
	if player.character == "V" 
		scr_hurtplayer(player);
	else
	{
		if player.state == states.dogmount || player.state == states.dogmountspin
		{
			player.vsp = -18
			player.sprite_index = spr_player_machfreefall
			player.image_index = 0
		}
		//Burn player
		else if player.state != states.gameover && player.state != states.rideweenie 
		&& player.state != states.hitlag
		{
			with player
				scr_transfobump(false);
			
			if player.state != states.firedrill
				tv_push_prompt_once(tv_create_prompt("This is the firedrill transformation text", 2, spr_tv_fireass, 3), "fireass");
			
			player.image_blend = c_white
			player.state = states.firedrill
			player.sprite_index = player.spr_firedrillstart
			player.image_index = 0
			with player
				event_perform(ev_step_begin, 0)
				
			player.sprite_index = player.spr_firedrillstart

			
			if FINAL_GAMEPLAY
				player.movespeed = player.hsp
			
			player.vsp = -24
			
			if !fmod_is_instance_playing(player.snd_fireass) 
			or fmod_get_instance_timeline_pos(player.snd_fireass) >= 5000
			{
				fmod_stop_instance_immediately(player.snd_fireass);
				fmod_play_instance(player.snd_fireass);
			}
			gp_vibration(1, 1, 0.85);
		}
	}
}