if maxwave > 1 && instance_exists(block_inst) || sprite_index = spr_arenagate_open
{
	if (hudgodown)
		yhudpos = lerp(yhudpos, 250, 0.015 * (speedup + 1))
	else
		yhudpos = lerp(yhudpos, 0, 0.095 * (speedup + 1))
		
	ishudfulldown = yhudpos > 220
	ishudfullup = yhudpos == 0
		
		
	var index = displaywave - 1 
	
	if displaywave >= maxwave
		index = 5
	
	draw_sprite(spr_bossrounds, index, 480, 540 + yhudpos);
}
