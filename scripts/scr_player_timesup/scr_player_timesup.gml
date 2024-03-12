function scr_player_timesup()
{
	xscale = 1
	inv_frames = false
	sprite_index = spr_Timesup
	alarm[7] = -1
	alarm[8] = -1
	alarm[5] = -1
	
	if place_meeting(x, y, obj_timesup)
	{
		if REMIX_GAMEPLAY
		{
			scr_sleep(50)
			instance_create(x, y, obj_bangeffect)
			repeat 3
				instance_create(x, y, obj_slapstar);
			scr_soundeffect(sfx_killenemy)
			
			with obj_camera
			{
				shake_mag = 3;
				shake_mag_acc = 3 / room_speed;
			}
		}
		
		state = states.gameover
		sprite_index = spr_deathend
		alarm[10] = 5
		vsp = -8
		hsp = -4
	}
	
	if room == timesuproom
	{
		x = 480
		y = 270
	}
	
	if floor(image_index) >= image_number - 1
		image_speed = 0
}

