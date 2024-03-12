function scr_player_machslide()
{
	var railh = 0, railmeet = instance_place(x, y + 1, obj_railparent);
	if railmeet then railh = railmeet.spdh;
	hsp = xscale * movespeed + railh;

	move = key_right + key_left
	
	if movespeed >= 0
	{
		if scr_pizzyphys_check()
			movespeed -= 0.35
		else
			movespeed -= 0.4
		movespeed = max(movespeed, 0);
	}

	//Animations
	if sprite_index == spr_machslidestart && floor(image_index) == image_number - 1
		sprite_index = spr_machslide
	
	if floor(image_index) == image_number - 1 && (sprite_index == spr_machslideboost)
        image_speed = 0
	else
		image_speed = 0.35

	landAnim = false
	
	//Back to other states
	//Normal
	if floor(movespeed) <= 0 && (sprite_index == spr_machslide or sprite_index == spr_crouchslide) 
	{
		state = states.normal
		image_index = 0
		if sprite_index == spr_machslide
			machslideAnim = true
		movespeed  = 0
	}
	
	if (scr_solidwall(x + xscale, y) or scr_solid_slope(x + xscale, y))
	&& (sprite_index == spr_machslide or sprite_index == spr_machslidestart)
	{
		state = states.bump
		if OLD_GAMEPLAY or (scr_pizzyphys_check() && !global.newpizzy)
		{
			sprite_index = spr_bump
			hsp = -xscale * 2.5
			vsp = -4
			image_index = 4
		}
		else
		{
			if spr_splat != spr_player_wallsplat || character == "P"
				sprite_index = spr_splat
			else
				sprite_index = spr_bump
	        image_index = 0
		}
	}

	if ((floor(image_index) >= image_number - 1 && sprite_index == spr_machslideboost) || sprite_index == spr_machboostfall)
	&& (grounded or global.animmachturn)
	{
		hsp = 0
		image_index = 0
		xscale *= -1
		movespeed = 8
		state = states.mach2
	}
	else if floor(image_index) >= image_number - 1 && sprite_index == spr_machslideboost
	{
		sprite_index = spr_machboostfall
		image_index = 0;
	}

	if ((floor(image_index) >= image_number - 1 && sprite_index == spr_mach3boost) || sprite_index == spr_mach3boostfall) 
	&& (grounded or global.animmachturn)
	{
		hsp = 0
		sprite_index = spr_mach4
		image_index = 0
		xscale *= -1
		movespeed = 12
		state = states.mach3
	}
	else if floor(image_index) >= image_number - 1 && sprite_index == spr_mach3boost
	{
		sprite_index = spr_mach3boostfall
		image_index = 0;
	}
	
	if sprite_index == spr_player_crouchslide && movespeed <= 0 && grounded 
	{
		facehurt = true
		state = states.normal
		sprite_index = spr_facehurtup
	}
	
	//Effects
	if !instance_exists(dashcloudid) && grounded
	{
		if !place_meeting(x, y + 1, obj_water)
		{
			with instance_create(x, y, obj_dashcloud2)
			{
				image_xscale = other.xscale
				other.dashcloudid = id
			}
		}
		else
		{
			with instance_create(x, y, obj_dashcloud2)
			{
				sprite_index = spr_watereffect
				image_xscale = other.xscale
				other.dashcloudid = id
			}
		}
	}
}