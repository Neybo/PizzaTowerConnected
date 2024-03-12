function scr_player_pogo()
{
	move = key_left + key_right;
	
	if move = 0 && hsp != 0
		hsp = xscale * movespeed
	else
		hsp = move * movespeed
	
	if move != 0 && !grounded
	{
		if movespeed < 6
			movespeed += 0.5
	}
	
	if move != xscale or move == 0 or (scr_solidwall(x + xscale, y) 
	&& !place_meeting(x + xscale, y, obj_destructibles))
	{
		movespeed = 0
		pogospeed = 6
	}
	
	if sign(hsp) != 0
		xscale = sign(hsp)
	else if move != 0
		xscale = move
	
	if move != xscale
		pogospeed = 6
	
	if grounded && !key_slap2 && (sprite_index != spr_playerN_pogobounce 
	&& sprite_index != spr_playerN_pogobouncemach && sprite_index != spr_playerSP_canebounce)
	{
		scr_soundeffect(sfx_Npogo3)
		pogospeedprev = false
		image_index = 0
		movespeed = 0
		vsp = 0
		
		if pogochargeactive
			sprite_index = spr_playerN_pogobouncemach
		else
		{
			sprite_index = spr_playerN_pogobounce
			if character == "SP"
				sprite_index = spr_playerSP_canebounce
		}
		instance_create(x, y, obj_landcloud)
	}
	
	if floor(image_index) == 3 && !pogospeedprev && (sprite_index == spr_playerN_pogobounce 
	or sprite_index == spr_playerN_pogobouncemach or sprite_index == spr_playerSP_canebounce)
	{
		if key_jump2
		{
			vsp = -12
			if scr_pizzyphys_check()
				vsp = -16
		}
		else if key_down
			vsp = -3
		else
		{
			vsp = -6
			if scr_pizzyphys_check()
				vsp = -10
		}
		
		if move == xscale && movespeed < 12
		{
			pogospeed += 4
			if FINAL_GAMEPLAY
				pogospeed = min(pogospeed, 25)
		}
		if move == -xscale && movespeed > 0
			pogospeed = 6
		movespeed = pogospeed
		pogospeedprev = true
	}
	
	if floor(image_index) >= image_number - 1 && (sprite_index == spr_playerN_pogobounce 
	or sprite_index == spr_playerN_pogofallmach or sprite_index == spr_playerN_pogobouncemach 
	or sprite_index == spr_playerN_pogostart)
	{
		if pogochargeactive
			sprite_index = spr_playerN_pogofallmach
		else
			sprite_index = spr_playerN_pogofall
	}
	
	if sprite_index == spr_playerSP_canebounce && image_index >= image_number - 1
		sprite_index = spr_playerSP_canefall;
	
	if pogospeed > 12 && !pogochargeactive && character == "N"
	{
		pogochargeactive = true
		pogocharge = 100
		flash = true
	}
	
	if movespeed > 12
		pogocharge = 100
	
	if !key_attack
		state = states.normal
	
	//Noise Bomb
	if key_shoot2 && character == "N" && noisebombcooldown <= 0
	{
		scr_soundeffect(sfx_noisewoah)
		noisebombcooldown = 30
		with instance_create(x, y, obj_playerbomb)
			image_xscale = other.xscale
	}
	image_speed = 0.35
	
	//Taunt
	if key_taunt2
		scr_player_taunt();
}

