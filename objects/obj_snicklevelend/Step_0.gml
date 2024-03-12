var snick = false;
with obj_player
	if character == "S" snick = true;

if !hit && (!snick or (!global.panic && room != snick_challengeend))
{
	visible = false;
	exit;
}
visible = true;

if floor(image_index) >= image_number - 1
{
	image_speed = 0;
	with obj_player
	{
		if state != states.door && grounded
		{
			state = states.door;
			doorx = x;
			sprite_index = spr_snick_victory;
			image_index = 0;
			
			other.alarm[0] = 200;
		}
	}
}

if room == snick_challengeend && global.snickrematch
	fmod_set_pitch(global.music, min(distance_to_object(obj_player) / (room_width - 480), 1));

if hit
{
	with obj_camera
	{
		targetoverride = other.id;
		targetgoingback = true;
	}
	obj_player.x = clamp(obj_player.x, _camx, _camx + _camw);
}