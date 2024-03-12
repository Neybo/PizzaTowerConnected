if playerid == noone
{
	shake = 0;
	if tired > 0
		tired--;
	
	var player = instance_nearest(x, y, obj_player);
	if instance_exists(player)
	{
		var lookplayer = point_direction(x, y, player.x, player.y);
		handsx = x + lengthdir_x(80, lookplayer);
		handsy = max(y + lengthdir_y(80, lookplayer), y);
	}
	sprite_index = spr_flingfrog;
	
	// collide
	if tired <= 0 && player.state != states.fling && rectangle_in_rectangle(handsx - 16, handsy - 16, handsx + 16, handsy + 16, player.bbox_left, player.bbox_top, player.bbox_right, player.bbox_bottom)
	{
		sprite_index = spr_flingfrogmad;
		scr_soundeffect(sfx_flingfrog);
		playerid = player;
		
		player.state = states.fling;
		if player.vsp < 5
			player.vsp = 5;
		player.sprite_index = spr_playerSP_candybegin;
		player.image_index = 0;
		player.x = handsx;
		player.y = handsy;
		player.hsp = sign(player.hsp) * min(abs(player.hsp), 30)
		
		with player
		{
			while scr_solid(x, y)
			{
				y--;
				vsp = 0;
			}
		}
		
		with instance_create(player.x, player.y, obj_customeffect)
		{
			sprite_index = spr_candyifiedeffect1;
			followplayer = true;
		}
		with instance_create(player.x, player.y, obj_customeffect)
		{
			sprite_index = spr_candyifiedeffect2;
			followplayer = true;
			loop = true;
			player.candyeffect = id;
		}
	}
}
if playerid != noone
{
	if !instance_exists(playerid) or playerid.state != states.fling
	{
		playerid = noone;
		tired = 30;
		exit;
	}
	playerid.x = clamp(playerid.x, x - 216, x + 216);
	
	tired++;
	if handsx != playerid.x or handsy != playerid.y
		tired = 0;
	
	handsx = playerid.x;
	handsy = playerid.y;
	
	shake = (tired - 5) / 50;
	
	if (handsy <= y && playerid.vsp < 0) or tired >= 120
	{
		with playerid
		{
			image_index = 0;
			sprite_index = spr_playerSP_candytransitionup;
			jumpAnim = true;
			state = states.jump;
			vsp = -16;
			jumpstop = true;
			instance_destroy(candyeffect);
			scr_soundeffect(sfx_flingfrogjump);
		}
		playerid = noone;
		tired = 25;
	}
}

