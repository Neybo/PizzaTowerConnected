function scr_player_rocket()
{
	hsp = xscale * movespeed
	move = key_right + key_left
	vsp = 0
	alarm[5] = -1
	alarm[8] = 60
	alarm[7] = 120
	hurted = true
	
	if sprite_index != spr_rocketstart
	{
		if key_up
		{
			vsp = -3
			if grounded
				y -= 8
		}
		if key_down
			vsp = 3
		if movespeed < 14
			movespeed = 14
		var rocket = instance_place(x,y,obj_rocket)
		if ((key_jump || input_buffer_jump < 8) && (!rocket || rocket.image_xscale != xscale || movespeed > 15))
		{
			dir = xscale;
			state = states.mach2;
			sprite_index = spr_mach2jump;
			jumpstop = false;
			vsp = -11;
			instance_create(x, y, obj_jumpdust);
			with (instance_create(x, y + 12, obj_explosioneffect))
			{
				hsp = other.xscale * 6;
				vsp = 5;
				image_xscale = sign(hsp);
			}
		}
	}
	else
	{
		hsp = 0
		movespeed = 0
		vsp = 0
		if floor(image_index) == image_number - 1
		{
			sprite_index = spr_rocket
			image_index = 0
			movespeed = 14
		}
	}

	if (grounded)
	{
		move = key_left + key_right;
		if (move != 0 && move != xscale && sprite_index != spr_rocketstart && state != states.mach2)
		{
			state = states.rocketslide;
			scr_soundeffect(sfx_machslideboost)
			sprite_index = spr_rocketslide;
			image_index = 0;
		}
	}
	if movespeed < 24 && move == xscale
	{
		movespeed += 0.1
		if !instance_exists(crazyruneffectid) && grounded && sprite_index != spr_rocketstart
		{
			if movespeed > 12
			{
				with instance_create(x, y, obj_crazyruneffect)
				{
					playerid = other.object_index
					other.crazyruneffectid = id
				}
			}
			if sprite_index == spr_crazyrun
			{
				with instance_create(x, y, obj_dashcloud)
				{
					image_xscale = other.xscale
					sprite_index = spr_flamecloud
				}
			}
		}
	}
	else if movespeed > 12 && move != xscale
		movespeed -= 0.1
	
	if sprite_index != spr_rocketstart && sprite_index != spr_rocketslide
		sprite_index = spr_rocket
	
	if grounded
		vsp -= 1
	if scr_solidwall(x + sign(hsp), y)
	&& (!place_meeting(x + sign(hsp), y, obj_metalblock) or (character == "V" && OLD_GAMEPLAY))
	&& (!place_meeting(x + sign(hsp), y, obj_destructibles) or (character == "V" && OLD_GAMEPLAY))
	&& !place_meeting(x + sign(hsp), y, obj_ratblock)
	{
		sprite_index = spr_rockethitwall
		groundpoundsnd = scr_soundeffect(sfx_groundpound)
		scr_soundeffect(sfx_bumpwall)
		
		with obj_camera
		{
			shake_mag = 20
			shake_mag_acc = 40 / room_speed
		}
		hsp = 0
		image_speed = 0.35
		
		with obj_baddie
		{
			if point_in_camera(x, y, view_camera[0])
			{
				stun = true
				alarm[0] = 200
				ministun = false
				vsp = -5
				hsp = 0
			}
		}
		
		flash = false
		state = states.bump
		hsp = -3.5 * xscale
		x -= xscale * 15 
		vsp = -6
		mach2 = 0
		image_index = 0
		instance_create(x - 10, y + 10, obj_bumpeffect)
		instance_create(x, y, obj_playerexplosion)
	}
	else if place_meeting(x + sign(hsp), y, obj_ratblock)
	{
		x += 2 * sign(xscale)
	}
	if !instance_exists(dashcloudid) && grounded && !place_meeting(x, y + 1, obj_water)
	{
		with instance_create(x, y, obj_superdashcloud)
		{
			image_xscale = other.xscale
			other.dashcloudid = id
		}
	}
	if sprite_index != spr_rocketstart && !instance_exists(chargeeffectid)
	{
		with instance_create(x, y, obj_chargeeffect)
		{
			playerid = other.object_index
			other.chargeeffectid = id
		}
	}
	
	if sprite_index == spr_mach4
		image_speed = 0.4
	if sprite_index == spr_crazyrun
		image_speed = 0.75
	if sprite_index == spr_rollgetup or sprite_index == spr_mach3hit
		image_speed = 0.4
	else
		image_speed = 0.4
}

