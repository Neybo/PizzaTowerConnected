function scr_player_chainsaw() {
	landAnim = false
	movespeed = 17
	hsp = movespeed * xscale

	if floor(image_index) == image_number - 1 && sprite_index == spr_player_chainsaw
		sprite_index = spr_player_chainsawend
	else if floor(image_index) == image_number - 1 && sprite_index == spr_player_chainsawstart
		sprite_index = spr_player_chainsaw

	if (sprite_index == spr_player_chainsawend && floor(image_index) == image_number - 1)
	{
		if character == "N" && noisetype == 0
		{
			image_index = 0
			state = states.mach3
			sprite_index = spr_playerN_jetpackboost
		}
		else
		{
			image_index = 0
			state = states.mach3
			sprite_index = spr_mach4
		}
	}

	// charge effect
	if !instance_exists(chargeeffectid)
	{
		with instance_create(x,y,obj_chargeeffect)
		{
			playerid = other.object_index	
			other.chargeeffectid = id
		}
	}

	if climb_wall() && ((!place_meeting(x + hsp, y, obj_metalblock) 
		&& !place_meeting(x + hsp, y, obj_mach3solid)))
	{
		image_index = 0
		instance_create(x + (xscale * 10), y + 10, obj_bumpeffect)
		hsp = -xscale * 5
		vsp = -3
		state = states.bump
	}

	if sprite_index == spr_player_chainsawend
		image_speed = 0.5
	else
		image_speed = 0.4
}
