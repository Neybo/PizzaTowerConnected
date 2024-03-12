if sprite_index == spr_noise_button
{
	if floor(image_index) >= image_number - 1
	{
		hspeed = 2.8
		image_xscale = 1
		sprite_index = spr_noise_walk
	}
	
	if floor(image_index) == 32 && !woah
	{
		woah = true;
		scr_soundeffect(sfx_noisewoah);
	}
	
	if floor(image_index) == 87 && !global.panic
	{
		// setup pizzatime
		scr_soundeffect(sfx_killenemy);
		instance_create(x, y, obj_itspizzatime)
		global.panic = true
	
		global.minutes = 2
		global.seconds = 59
		if global.modifier == mods.no_toppings
		{
			global.minutes = 3
			global.seconds = 29
		}
		
		if global.panicbg
			scr_panicbg_init()
		
		global.wave = 0;
		if OLD_GAMEPLAY
			global.maxwave = (global.minutes * 60 + global.seconds) * 60;
		else
		{
			global.fill = ((global.minutes * 60 + global.seconds) * 60) * obj_chunktimer.fillrate;
			global.maxwave = global.fill
		    with obj_tv
		        chunkmax = global.fill
		}
		scr_panictimemusic()
		
		with obj_camera
			alarm[1] = 60;
		
		// scare player
		with obj_player
		{
			scr_soundeffect(snd_fireass);
			state = states.backbreaker;
			sprite_index = spr_bossintro;
			image_index = 0;
			image_speed = 0.35;
		}
	}
}

