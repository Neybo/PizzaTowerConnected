function scr_scareenemy()
{
	var player = instance_nearest(x, y, obj_player)
	if !player
		exit;
	
	if player.x > x - 400 && player.x < x + 400 && y <= player.y + 60 && y >= player.y - 60
	&& state != states.grabbed && state != states.idle && state != states.stun
	&& (player.state == states.chainsaw or player.state == states.mach3 
	or player.state == states.machslide or player.state == states.rideweenie 
	or player.state == states.rocket or player.state == states.tacklecharge 
	or (player.state == states.knightpepslopes && FINAL_GAMEPLAY)
	or player.state == states.dogmountspin)
	{
		if !global.snickrematch
		{
			if object_index == obj_spitcheese
				throwdir = image_xscale;
			
			state = states.idle
			sprite_index = scaredspr
			if x != player.x
				image_xscale = -sign(x - player.x)
			scaredbuffer = 100 / (global.stylethreshold + 1)
			if grounded && object_index != obj_kentukybomber
				vsp = OLD_GAMEPLAY ? -5 : -3
			
			if object_index == obj_coolpineapple
			{
				invincible = false
				inv_timer = 0
			}
		}
		else
			rematchscare = true;
	}
	else
		rematchscare = false;
}