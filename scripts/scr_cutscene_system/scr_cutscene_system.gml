function cutscene_gustavo_start()
{
	if !instance_exists(obj_fadeout)
	&& obj_player.state != states.taxi && obj_player.state != states.comingoutdoor 
	&& obj_player.state != states.hurt
	{
		with obj_player
		{
			visible = true
			image_alpha = 1
			state = states.actor
			sprite_index = spr_idle
			image_speed = 0.35
			xscale = 1
			hsp = 0
			vsp = 0
		}
		with obj_gustavo
		{
			state = states.actor
			if !global.failcutscene
				sprite_index = spr_gustavo_makepizza;
			else
				sprite_index = spr_gustavo_idle;
			image_speed = 0.35
			image_xscale = -1
		}
		cutscene_end_action();
	}
}

function cutscene_gustavo_end()
{
	var finish = false;
	with obj_player
	{
		if sprite_index == spr_player_gnomepizza
		{
			if image_index > image_number - 1
			{
				finish = true;
				state = states.normal;
			}
		}
	}
	if finish
	{
		global.showgnomelist = true;
		global.failcutscene = false;
		global.pizzadelivery = true;
		global.hp = 8;
	
		with obj_gustavo
			state = states.normal;
		
		if !instance_exists(obj_gnome_checklist)
			instance_create(0, 0, obj_gnome_checklist);
	
		cutscene_end_action()
	}
}

function cutscene_customer_start(player)
{
    var finish = false
    with player
    {
        if sprite_index == spr_throw && image_index > image_number - 1
            sprite_index = spr_idle
    }
    if !instance_exists(obj_pizzacustomer)
    {
        with player
        {
            state = states.actor
            movespeed = 0
            hsp = 0
            image_speed = 0.35
            sprite_index = spr_throw
            image_index = 0
            var depth_obj = other
            global.pizzadelivery = false
            with instance_create(x, y, obj_pizzacustomer)
            {
                depth = depth_obj.depth
                hsp = 0
                vsp = -8
            }
        }
    }
    if instance_exists(obj_pizzacustomer)
    {
        with obj_pizzacustomer
        {
            if grounded
                finish = true
        }
    }
    if finish
        cutscene_end_action()
}

function cutscene_customer_end(player, targetroom)
{
	with obj_customeractor
        happy = true
	
    with instance_create(player.x - 1000, player.y, obj_taxi_cutscene)
    {
        targetplayer = player
        depth = -127
        targetDoor = "E"
        targetRoom = targetroom
    }
    cutscene_end_action()
}

function cutscene_customer_check(gnomeid, player, gnomehouse)
{
    with obj_gnome_checklist
        gnome_check[gnomeid] = true
	
    global.pizzasdelivered++
    if instance_exists(obj_gnomecustomerblock)
        instance_destroy(obj_gnomecustomerblock)
    with instance_create(player.x, player.y, obj_pizzaboxunopen)
    {
        content = gnomehouse.content
        depth = player.depth
        visible = false
    }
    ds_list_add(global.saveroom, gnomehouse.id)
    cutscene_end_action()
}

function cutscene_end_action()
{
	scene++;
	if scene > array_length(scene_info) - 1
		instance_destroy()
}

function cutscene_wait(frames)
{
	timer++
	if timer >= frames
	{
		timer = 0
		cutscene_end_action()
	}
}

function cutscene_set_sprite(_obj, _spr, _spd, _xscale)
{
	with _obj
	{
		sprite_index = _spr;
		image_speed = _spd;
		image_xscale = _xscale;
		image_index = 0;
		xscale = _xscale;
	}
	cutscene_end_action();
}

function cutscene_move_player(player, x_to, max_hsp, threshold)
{
	var finish = false;
	with player
	{
		sprite_index = spr_move;
		
		var mv = abs(hsp) / 6;
		image_speed = lerp(0.35, 0.6, floor(mv) + (floor(frac(mv) * 100) / 100)); // limit to 2 decimal places
		
		// speed
		if x < x_to - threshold
		{
			xscale = 1;
			if hsp < max_hsp
				hsp += 0.5;
			else
				hsp = max_hsp;
		}
		else if x > x_to + threshold
		{
			xscale = -1;
			if hsp > -max_hsp
				hsp -= 0.5;
			else
				hsp = -max_hsp;
		}
		else
		{
			hsp = 0;
			finish = true;
		}
	}
	
	if finish
		cutscene_end_action();
	
	// step cloud
	with player
	{
		if (floor(image_index) == 3 or floor(image_index) == 8) && !steppy && character != "V"
		{
			instance_create(x, y + 43, obj_cloudeffect);
			steppy = true;
		}
		if floor(image_index) != 3 && floor(image_index) != 8
			steppy = false;
	}
}

function cutscene_image_index(_obj, _index)
{
	with _obj
		image_index = _index
	cutscene_end_action();
}

function cutscene_waitfor_sprite(_obj)
{
	var finish = false;
	with _obj
	{
		if image_index > image_number - 1
		{
			finish = true;
			image_index = image_number - 1;
		}
	}
	if finish
		cutscene_end_action();
}

function cutscene_set_hsp(_obj, _hsp)
{
	with _obj
		hsp = _hsp;
	cutscene_end_action();
}

function cutscene_check_collision(obj1, obj2)
{
	var finish = false;
	with obj1
	{
		if place_meeting(x, y, obj2)
			finish = true;
	}
	if finish
		cutscene_end_action();
}

function cutscene_move_actor(_obj, xx, yy, interp)
{
	var finish = false;
	with _obj
	{
		x = lerp(x, xx, interp);
		y = lerp(y, yy, interp);
		
		if x > xx - 6 && x < xx + 6
		&& y > yy - 6 && y < yy + 6
		{
			x = xx;
			y = yy;
			
			finish = true;
		}
	}
	if finish
		cutscene_end_action()
}

function cutscene_taxi_start(player)
{
	with player
	{
		global.failcutscene = true;
		global.showgnomelist = false;
		state = states.actor;
		cutscene = true;
		image_speed = 0.5;
		sprite_index = spr_outofpizza1;
		image_index = 0;
		vsp = -14;
		image_speed = 0.35;
	}
	cutscene_end_action();
}

function cutscene_player_check_ground(player)
{
	var finish = false;
	with player
	{
		if grounded
			finish = true;
	}
	if finish
		cutscene_end_action();
}

function cutscene_taxi_end(player, target_room)
{
	with player
	{
		cutscene = true;
		state = states.actor;
		
		if grounded && state != states.hurt
		{
			hsp = 0;
			vsp = 0;
			
			with instance_create(x - 1000, y, obj_taxi_cutscene)
			{
				targetplayer = player;
				depth = -127;
				targetDoor = "E";
				targetRoom = target_room;
			}
			
			with other
			{
				global.failcutscene = true;
				cutscene_end_action();
			}
		}
	}
}

function cutscene_customer_create(xx, yy, _idle, _happy, _xscale)
{
	with instance_create(xx, yy, obj_customeractor)
	{
		image_xscale = _xscale;
		depth = other.depth - 1;
		sprite_index = _idle;
		spr_idle = _idle;
		spr_happy = _happy;
	}
	cutscene_end_action();
}

function cutscene_gustavofail_start()
{
	if !instance_exists(obj_fadeout) && obj_player.state != states.taxi 
	&& obj_player.state != states.comingoutdoor
	{
		with obj_player
		{
			visible = true;
			image_alpha = 1;
			state = states.actor;
			sprite_index = spr_player_gnomecutscene1;
			image_speed = 0.35;
			xscale = 1;
			hsp = 0;
			vsp = 0;
		}
		with obj_gustavo
		{
			state = states.actor;
			sprite_index = spr_gustavo_idle;
			image_speed = 0.35;
			image_xscale = -1;
		}
		
		global.failcutscene = false;
		cutscene_end_action();
	}
}

function cutscene_gustavofail_end(time)
{
	timer++;
	with obj_gustavo
		visible = false;
	with obj_player
	{
		xscale = -1;
		sprite_index = spr_gustavo_pummel;
		
		if floor(image_index) == 4
		{
			if !steppy
			{
				repeat 3
					instance_create(x - 20, y - 20, obj_slapstar)
				scr_soundeffect(sfx_pephurt);
			
				with instance_create(x - 20, y - 20, obj_smallnumber)
				{
					negative = true;
					number = "-50";
				}
			
				repeat min(global.collect, 10) instance_create(x, y, obj_pizzaloss);
				global.collect = max(global.collect - 50, 0);
			}
			steppy = true;
		}
		else
			steppy = false;
	}
	if timer >= time
	{
		with obj_gustavo
		{
			visible = true;
			sprite_index = spr_gustavo_idle;
		}
		
		with obj_player
		{
			state = states.normal;
			scr_hurtplayer(id);
			hsp = 0;
			movespeed = 0;
			xscale = 1;
		}
		cutscene_end_action();
	}
}

