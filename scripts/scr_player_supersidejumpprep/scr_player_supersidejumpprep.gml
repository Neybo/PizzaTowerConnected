function scr_player_supersidejumpprep(){
	vsp = 0
	hsp = 0
	sprite_index = spr_superjumpsideprep
	image_speed = 0.35
	if animEnd
	{
		state = states.supersidejump
		movespeed = 12
		sprite_index = spr_superjumpside
		image_index = 0
	}
}