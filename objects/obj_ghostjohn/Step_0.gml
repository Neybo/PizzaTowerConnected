switch (state)
{
	case 0:
		targetplayer = instance_nearest(x, y, obj_player);
		var _g = distance_to_point(targetplayer.x, targetplayer.y);
		if (_g < 150)
			movespeed = 2;
		else if (_g < 300)
			movespeed = 3;
		else if (_g < 450)
			movespeed = 7;
		else
			movespeed = 11;
		var _d = point_direction(x, y, targetplayer.x, targetplayer.y);
		hsp = lengthdir_x(movespeed, _d);
		vsp = lengthdir_y(movespeed, _d);
		image_xscale = (targetplayer.x != x) ? sign(targetplayer.x - x) : image_xscale;
		x += hsp;
		y += vsp;
		break;
	
	case 1:
		var acc = 0.05;
		if (!fadein)
		{
			image_alpha = Approach(image_alpha, 0, acc);
			with (playerid)
			{
				hsp = 0;
				vsp = 0;
				movespeed = 0;
				x = hitX;
				y = hitY;
				image_alpha = other.image_alpha;
			}
			if (image_alpha <= 0)
			{
				fadein = true;
				with (playerid)
				{
					x = roomstartx;
					y = roomstarty;
					other.x = other.xstart;
					other.y = other.ystart;
				}
			}
		}
		else
		{
			image_alpha = Approach(image_alpha, 1, acc);
			with (playerid)
			{
				image_alpha = other.image_alpha;
				if (image_alpha >= 1)
				{
					state = states.normal;
					other.state = states.normal;
					cutscene = false
					other.image_alpha = other.start_alpha;
				}
			}
		}
		break;
		
			case 2:
		image_alpha += 0.01;
		if image_alpha >= 0.75
		state = 0
		if image_alpha <= 0.02
		{
			x = obj_player.x
			y = obj_player.y
		}
		break;
}