/// general utility functions
function point_in_camera(x, y, cam)
{
	var camx = camera_get_view_x(cam);
	var camy = camera_get_view_y(cam);
	var camw = camera_get_view_width(cam);
	var camh = camera_get_view_height(cam);
	return point_in_rectangle(x, y, camx, camy, camx + camw, camy + camh);
}

/*
 * Returns true if the array contains any instances that match the provided element
 * otherwise returns false
 */
function array_contains(array, element) {
	for (var i = 0; i < array_length(array); i++) {
		if (array[i] == element) {
			return true;
		}
	}
	return false;
}

function instance_in_camera(inst, cam)
{
	if (inst == undefined)
		inst = id
	if (cam == undefined)
		cam = view_camera[0]
	var camx = camera_get_view_x(cam);
	var camy = camera_get_view_y(cam);
	var camw = camera_get_view_width(cam);
	var camh = camera_get_view_height(cam);
	
	var result = false;
	var xx = inst.x - sprite_get_xoffset(inst.sprite_index);
	var yy = inst.y - sprite_get_yoffset(inst.sprite_index);
	
	// left bottom
	result |= point_in_rectangle(
		xx + sprite_get_bbox_left(inst.sprite_index), 
		yy + sprite_get_bbox_bottom(inst.sprite_index), 
	camx, camy, camx + camw, camy + camh);
	
	// left top
	if !result
	{
		result |= point_in_rectangle(
			xx + sprite_get_bbox_left(inst.sprite_index), 
			yy + sprite_get_bbox_top(inst.sprite_index), 
		camx, camy, camx + camw, camy + camh);
	}
	
	// right bottom
	if !result
	{
		result |= point_in_rectangle(
			xx + sprite_get_bbox_right(inst.sprite_index), 
			yy + sprite_get_bbox_bottom(inst.sprite_index), 
		camx, camy, camx + camw, camy + camh);
	}
	
	// right top
	if !result
	{
		result |= point_in_rectangle(
			xx + sprite_get_bbox_right(inst.sprite_index), 
			yy + sprite_get_bbox_top(inst.sprite_index), 
		camx, camy, camx + camw, camy + camh);
	}
	return result;
}

/// game specific
function check_sugary(rmin = room, char = false)
{
	if (char)
	{
		with (obj_player)
			if (character == "SN" || character == "SP")
				return 1;
	}
	else
	{
		var rminname = room_get_name(rmin)
		if rmin == hub_roomSP
		or string_startswith(rminname, "cotton_")
		or string_startswith(rminname, "entryway_")
		or string_startswith(rminname, "molasses_")
		or string_startswith(rminname, "sugarytut_")
		or string_startswith(rminname, "cafe_")
		//or string_startswith(room_get_name(rmin), "mines_")
			return true;
	}
	return false;
}

function GamepadSetVibration(player, left, right, dec)
{
	gp_vibration(left, right, dec)
}

function gp_vibration(left, right, dec)
{
	if global.gamepadvibration
	{
		with obj_controller
			vibration = [left, right, dec];
	}
}

/// enemy
function increase_combo()
{
	if object_index = obj_junk
		return;
   
	scr_failmod(mods.pacifist);
	
	var funny = true;
	if object_index == obj_baddiecollisionbox
	&& instance_exists(baddieID)
	{
		if baddieID.object_index == obj_pizzaballOLD or !baddieID.killreward 
			funny = false;
	}
	else if object_is_ancestor(object_index, obj_baddie)
	{
		if object_index == obj_pizzaballOLD or !killreward 
			funny = false;
	}
	else
		funny = false
	
	if /*FINAL_GAMEPLAY &&*/ funny
	{
		if (global.heatmeter)
		{
			global.style += 2 + global.combo;
			global.heattime = 60;
		}
		global.combo += 1;
		global.combotime = 60;
		
		with obj_player
		{
			supercharge++  
			if supercharge > 10 && supercharge % 10 == 0 
			{
				global.ammo = min(global.ammo + global.useammo, 3)
				global.bullet = min(global.bullet + global.usebullet, 3)
			}
			if !(global.useammo)
				global.ammo = 0
			if !global.usebullet || global.breakdance
				global.bullet = 0
		}
	}
	else
		global.combotime = 60;
}

function scr_hitthrow(baddie, player = noone, lag = 5)
{
	if !global.hitstun
		lag = 0
	with baddie
	{
		if state != states.hit
		{
			//	if invtime <= 0
			//	increase_combo();
			
			repeat 3
			{
				create_particle(x, y, particles.baddiegibs)
				instance_create(x, y, obj_slapstar)
			}
			instance_create(x, y, obj_parryeffect)
			alarm[3] = 3;
			
			if (object_index != obj_pizzaballOLD)
			hp -= 1;
			thrown = true;
						
			hitLag = lag;
			hitX = x;
			hitY = --y;
			state = states.hit;
			
			hsp = hithsp;
			vsp = hitvsp;
			
			grounded = false;
		}
	}
	
	with player
	{
		if state != states.hitlag && global.hitstun
		{
			if scr_solid(x, y)
			{
				x = hitX;
				y = hitY;
			}
			tauntstoredmovespeed = movespeed;
			tauntstoredsprite = sprite_index;
			tauntstoredstate = state;
			tauntstoredvsp = vsp;
			state = states.hitlag;
			
			hitLag = lag;
			hitX = x;
			hitY = y;
		}
	}
}

function create_heatattack_afterimage(x, y, sprite, index, xscale)
{
	var velocity = 6;
	with instance_create(x, y, obj_enemyafterimage)
	{
		parent = other.id;
		sprite_index = sprite;
		image_index = index;
		image_xscale = xscale;
		hspeed = velocity;
		alarm[0] = 8;
		alarm[1] = -1;
		alarm[2] = -1;
	}
	with instance_create(x, y, obj_enemyafterimage)
	{
		parent = other.id;
		sprite_index = sprite;
		image_index = index;
		image_xscale = xscale;
		hspeed = -velocity;
		alarm[0] = 8;
		alarm[1] = -1;
		alarm[2] = -1;
	}
	with instance_create(x, y, obj_enemyafterimage)
	{
		parent = other.id;
		sprite_index = sprite;
		image_index = index;
		image_xscale = xscale;
		vspeed = velocity;
		alarm[0] = 8;
		alarm[1] = -1;
		alarm[2] = -1;
	}
	with instance_create(x, y, obj_enemyafterimage)
	{
		parent = other.id;
		sprite_index = sprite;
		image_index = index;
		image_xscale = xscale;
		vspeed = -velocity;
		alarm[0] = 8;
		alarm[1] = -1;
		alarm[2] = -1;
	}
}

function safe_get(inst, variable)
{
	if instance_exists(inst) && variable_instance_exists(inst, variable)
		return variable_instance_get(inst, variable);
	return noone;
}

function heat_calculate(num) {
	return num + round(num * global.stylemultiplier);
}

function concat() //gml_Script_concat
{
    _string = ""
    for (i = 0; i < argument_count; i++)
        _string += string(argument[i])
    return _string;
}

function instance_create_unique(argument0, argument1, argument2) //gml_Script_instance_create_unique
{
    if instance_exists(argument2)
        return -4;
    var b = instance_create(argument0, argument1, argument2)
    return b;
}