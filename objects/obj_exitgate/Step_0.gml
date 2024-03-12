if sprite_index != spr_exitgateclosing_ss
{
	if global.failedmod
	{
		if image_index == 1 && instance_in_camera(id, view_camera[0])
		{
			gp_vibration(1, 1, 0.9);
			scr_soundeffect(sfx_groundpound);
			
			with obj_camera
			{
				shake_mag = 5;
				shake_mag_acc = 15 / room_speed;
			}
		}
		image_index = 0;
	}
	else if global.panic || forceopen
		image_index = 1;
}
else if floor(image_index) >= image_number - 1
{
	sprite_index = spr_exitgate_ss;
	image_index = 0;
	image_speed = 0;
}

// disable if youre snick
var snick = false;
with obj_player
	if character == "S" snick = true;

visible = !snick;
if snick && global.panic
{
	instance_change(obj_snicklevelend, true);
	image_index = 0
	y += 83
	exit;
}
// snick rematch end slowdown
if room == snick_challengeend && global.snickrematch
	fmod_set_pitch(global.music, min(distance_to_object(obj_player) / (room_width - 480), 1));

