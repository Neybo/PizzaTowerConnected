function scr_pummel(setspeed = true, setsprite = false)
{
	sprite_index = choose(spr_suplexmash1, spr_suplexmash2, spr_suplexmash3, spr_suplexmash4);
	if character == "P"
		sprite_index = choose(spr_player_suplexmash1, spr_player_suplexmash2, 
		spr_player_suplexmash3, spr_player_suplexmash4, spr_player_suplexmash5, spr_player_suplexmash6, spr_player_suplexmash7);
	if character == "SP" && FINAL_GAMEPLAY
		sprite_index = choose(spr_suplexmash1, spr_suplexmash2, spr_suplexmash3, spr_suplexmash4, 
		spr_playerSP_suplexmash5, spr_playerSP_suplexmash6);
	if character == "SP" && shotgunAnim
		sprite_index = spr_playerSP_canehit;
		
	if !setsprite
	{
		image_index = 0;
		state = states.tackle;
	
		if setspeed
		{
			movespeed = 3;
			vsp = -3;
		}
	}
}

