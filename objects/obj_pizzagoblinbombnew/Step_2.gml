if (defused)
	countdown -= 0.5;
if (countdown < 50)
	sprite_index = bomblit_spr;
if (countdown <= 0)
{
	instance_destroy();
	exit;
}
if (kickbuffer > 0)
{
	if (!place_meeting(x, y, obj_player))
		kickbuffer = 0;
}
switch (state)
{
	case states.normal:
		hsp = movespeed * image_xscale;
		if (place_meeting(x + hsp, y, obj_solid) && !place_meeting(x + hsp, y, obj_ratblock))
		{
			image_xscale *= -1;
		}
		if (place_meeting(x + hsp, y, obj_ratblock) || place_meeting(x, y + vsp, obj_ratblock))
		{
			instance_destroy();
			return
		}
		if (scr_solid(x + 1, y) || scr_solid(x - 1, y))
			drop = true;
		if (grounded)
		{
			if (movespeed > 0)
				movespeed -= 0.5;
		}
		if (place_meeting(x, y + 1, obj_railparent))
		{
			var _railinst = instance_place(x, y + 1, obj_railparent);
			hsp = _railinst.movespeed * _railinst.dir;
		}
		if (vsp < 12)
			vsp += grav;
		scr_collide();
		if scr_solid(x,y)
			scr_pushout(500)
		break;
	case states.grabbed:
		grounded = false;
		x = playerid.x + (-playerid.xscale * 6);
		y = playerid.y - 55;
		image_xscale = playerid.xscale;
		if (playerid.state != states.bombgrab && playerid.state != states.superslam)
			state = states.normal;
		if (playerid.state == states.superslam)
		{
			if (playerid.grounded)
				instance_destroy();
		}
		break;
	default:
		state = states.normal;
		break;
}
if (sprite_index == bomblit_spr)
{
	if (!fmod_is_instance_playing(snd))
		fmod_play_instance(snd);
}
if (sprite_index == spr_bombnew && instance_in_camera(id, view_camera[0]))
{
	if (floor(image_index) == 5 && !bouncesound)
	{
		bouncesound = true;
		scr_soundeffect(sfx_bombbounce)
	}
	else if (floor(image_index) != 5)
		bouncesound = false;
}
