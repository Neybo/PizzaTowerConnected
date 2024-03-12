var playerid = obj_player;
if !instance_exists(playerid)
	exit;

if sugary && !global.classiclap
{
	alarm[1] = -1
	siner--
	
	if sprite_index == spr_coneball or sprite_index == spr_coneballturn or sprite_index == spr_coneballspike
	{
		if x != playerid.x && sprite_index == spr_coneball
		{
			var xscale = sign(x - playerid.x);
			if image_xscale != xscale
			{
				image_xscale = xscale;
				sprite_index = spr_coneballturn;
				image_index = 0;
			}
		}
		if image_index >= image_number - 1 && (sprite_index == spr_coneballturn or sprite_index == spr_coneballspike)
		{
			image_index = 0;
			sprite_index = spr_coneball;
		}
		xx = lerp(xx, (playerid.x + cos(current_time / 1000) * -150) - _camx, 0.05);
		yy = lerp(yy, (playerid.y + sin(current_time / 1000) * -150) - _camy, 0.05);
		
		if siner <= 0
		{
			if attack % 2 == 0
			{
				siner = room_speed * 8;
				image_index = 0;
				sprite_index = spr_coneballraintrans;
				attack++;
			}
			else
			{
				siner = room_speed * random_range(4, 8);
				attack++;
				sprite_index = spr_coneballspike;
				image_index = 0;
			}
		}
		
		if sprite_index == spr_coneballspike
		{
			if floor(image_index) == 10
				mask_index = sprite_index;
			
			if place_meeting(x, y, playerid) && !instance_exists(obj_fadeout) && !instance_exists(obj_endlevelfade) && playerid.state != states.portal && playerid.state != states.door
			{
				if !place_meeting(x, y, obj_parryhitbox) && playerid.state != states.parry && image_index >= 14
				{
					with playerid
					{
						image_blend = c_white;
						grav = 0.5;
						a = 0;
						targetDoor = "A"
						room = timesuproom
						state = states.timesup
						sprite_index = spr_Timesup
						image_index = 0
						image_speed = 0.35
				
						if !fmod_is_instance_playing(global.jukebox)
						{
							fmod_stop_all()
							scr_soundeffect(mu_timesup)
						}
						instance_destroy(obj_fadeout)
						instance_destroy(other)
					}
					scr_soundeffect(sfx_coneball);
				}
			}
		}
		else
			mask_index = spr_player_mask;
	}
	if sprite_index == spr_coneballraintrans or sprite_index == spr_coneballrain or sprite_index == spr_coneballrainturn
	{
		xx = lerp(xx, (playerid.x + playerid.xscale * -150) - _camx, 0.05);
		yy = lerp(yy, (playerid.y - 150) - _camy, 0.05);
		
		if x != playerid.x && sprite_index == spr_coneballrain
		{
			var xscale = sign(x - playerid.x);
			if image_xscale != xscale
			{
				image_xscale = xscale;
				sprite_index = spr_coneballrainturn;
				image_index = 0;
			}
		}
		if image_index >= image_number - 1 && (sprite_index == spr_coneballraintrans or sprite_index == spr_coneballrainturn)
		{
			sprite_index = spr_coneballrain;
			image_index = 0;
		}
		
		if siner % 18 == 0
			instance_create(random_range(_camx, _camx + _camw), _camy - 64, obj_coneprojectile)
		
		if siner <= 0
		{
			image_alpha -= 0.1;
			if image_alpha <= 0
			{
				image_alpha = 1;
				siner = room_speed * random_range(4, 8);
				sprite_index = spr_coneball;
				reset_pos();
			}
		}
	}
	x = xx + _camx;
	y = yy + _camy;
}
else if finalbehavior
{
	var playerid = obj_player;
	if (!instance_exists(playerid))
		exit;
	var _move = true;
	with (obj_player)
	{
		if (state == states.taxi || state == states.victory || state == states.keyget 
		|| state == states.gottreasure || state == states.door)
			_move = false;
	}
	if (!treasure)
	{
		if (image_alpha >= 1)
		{
			if (!instance_exists(obj_fadeout) && !obj_player.cutscene)
			{
				if (_move)
				{
					var dir = point_direction(x, y, playerid.x, playerid.y);
					x += lengthdir_x(maxspeed, dir);
					y += lengthdir_y(maxspeed, dir);
				}
			}
		}
		else
			image_alpha += 0.01;
	}
	else
	{
		x = -200;
		y = -200;
	}
	if (!_move)
		image_alpha = Approach(image_alpha, 0, 0.1);
	
	if (place_meeting(x, y, playerid) && (!instance_exists(obj_fadeout)) 
	&& (!instance_exists(obj_endlevelfade)) && playerid.state != states.portal 
	&& playerid.state != states.door && image_alpha >= 1)
	{
	    if instance_exists(obj_toppinwarrior)
	    {
	        if (variable_global_exists("toppinwarriorid1") && instance_exists(global.toppinwarriorid1))
	            instance_destroy(global.toppinwarriorid1)
	        else if (variable_global_exists("toppinwarriorid2") && instance_exists(global.toppinwarriorid2))
	            instance_destroy(global.toppinwarriorid2)
	        else if (variable_global_exists("toppinwarriorid3") && instance_exists(global.toppinwarriorid3))
	            instance_destroy(global.toppinwarriorid3)
	        else if (variable_global_exists("toppinwarriorid4") && instance_exists(global.toppinwarriorid4))
	            instance_destroy(global.toppinwarriorid4)
	        else if (variable_global_exists("toppinwarriorid5") && instance_exists(global.toppinwarriorid5))
	            instance_destroy(global.toppinwarriorid5)
	        instance_create(x, y, obj_flash)
	        global.seconds = 59
	        global.fill = 709
	        obj_camera.alarm[1] = 60
	        obj_camera.ded = 0
	        instance_destroy()
	    }
	    else if (!instance_exists(obj_toppinwarrior))
	    {
	        with (playerid)
	        {
	            image_blend = c_white
	            grav = 0.5
	            a = 0
	            targetDoor = "A"
	            room = timesuproom
	            state = states.timesup
	            sprite_index = spr_Timesup
	            image_index = 0
	            fmod_stop_all()
	            scr_soundeffect(mu_timesup)
	            instance_destroy(obj_hallway)
	        }
	    }
	    instance_destroy()
	}
	if (maxspeed < 3 && image_alpha >= 1)
		maxspeed += 0.01;
}
else
{
	var mvsp = (maxspeed + (abs(obj_player.hsp) / 8))
	var turnspd = (mvsp / 50)
	var inradius = point_in_circle(x, y, playerid.x, playerid.y, 250)
	var dir = point_direction(x, y, (playerid.x + playerid.hsp), (playerid.y + playerid.vsp))
	var next_pos = point_direction(x, y, (x + hsp), (y + vsp))
	if (image_alpha >= 1 && playerid.state != (61 << 0))
	{
	    switch state
	    {
	        case (141 << 0):
	            hsp = Approach(hsp, lengthdir_x(mvsp, dir), turnspd)
	            vsp = Approach(vsp, lengthdir_y(mvsp, dir), turnspd)
	            if (inradius && (!end_turn))
	            {
	                state = (110 << 0)
	                saved_angle = dir
	                if ((saved_angle - 10) <= next_pos && (saved_angle + 10) >= next_pos)
	                    state = (141 << 0)
	            }
	            else if (!inradius)
	                end_turn = 0
	            x += hsp
	            y += vsp
	            break
	        case (110 << 0):
	            hsp = Approach(hsp, 0, turnspd)
	            vsp = Approach(vsp, 0, turnspd)
	            if (abs(hsp) <= 0 && abs(vsp) <= 0)
	            {
	                state = (141 << 0)
	                end_turn = 1
	            }
	            x += hsp
	            y += vsp
	            break
	    }

	}
	else
	    image_alpha = Approach(image_alpha, 1, 0.01)
	if (place_meeting(x, y, playerid) && (!instance_exists(obj_fadeout)) && (!instance_exists(obj_endlevelfade)) && playerid.state != states.portal && playerid.state != states.door && image_alpha >= 1)
	{
	    if instance_exists(obj_toppinwarrior)
	    {
	        if (variable_global_exists("toppinwarriorid1") && instance_exists(global.toppinwarriorid1))
	            instance_destroy(global.toppinwarriorid1)
	        else if (variable_global_exists("toppinwarriorid2") && instance_exists(global.toppinwarriorid2))
	            instance_destroy(global.toppinwarriorid2)
	        else if (variable_global_exists("toppinwarriorid3") && instance_exists(global.toppinwarriorid3))
	            instance_destroy(global.toppinwarriorid3)
	        else if (variable_global_exists("toppinwarriorid4") && instance_exists(global.toppinwarriorid4))
	            instance_destroy(global.toppinwarriorid4)
	        else if (variable_global_exists("toppinwarriorid5") && instance_exists(global.toppinwarriorid5))
	            instance_destroy(global.toppinwarriorid5)
	        instance_create(x, y, obj_flash)
	        global.seconds = 59
	        global.fill = 709
	        obj_camera.alarm[1] = 60
	        obj_camera.ded = 0
	        instance_destroy()
	    }
	    else if (!instance_exists(obj_toppinwarrior))
	    {
	        with (playerid)
	        {
	            image_blend = c_white
	            grav = 0.5
	            a = 0
	            targetDoor = "A"
	            room = timesuproom
	            state = states.timesup
	            sprite_index = spr_Timesup
	            image_index = 0
	            fmod_stop_all()
	            scr_soundeffect(mu_timesup)
	            instance_destroy(obj_hallway)
	        }
	    }
	    instance_destroy()
	}
	if (maxspeed < 8 && image_alpha == 1)
	    maxspeed += 0.005
}
