if !active
{
	active = true
	scr_soundeffect(sfx_dingding)
	scr_panictimemusic()
	if global.classiclap && global.lap == 4 
	{
	    global.fill = 0
		instance_create(0, -50, obj_ghostjohn)
		with obj_tv {
	        showtext = true
	        message = "The ghost of John has arrived..."
	        alarm[2] = 250
	    }
	}

	if global.classiclap && global.lap >= 4 
	{
	    global.fill = 0
	    with(obj_wartimer) {
	        addseconds += floor(global.lapextratime * 1.125)
	        alarm[0] = -1
	        alarm[2] = 1
	    }
	}
	else if global.classiclap && global.lap == 3 
	{
	    global.fill = 0
	    with obj_tv {
	        showtext = true
	        message = "Snick is coming..."
	        alarm[2] = 250
	    }
	    instance_create(room_width / 2, -50, obj_snickexe);
	    with(instance_create_unique(0, 0, obj_wartimer)) {
	        minutes = 0
	        seconds = 0
	        addseconds += floor(global.lapextratime * 1.1)
	        alarm[0] = -1
	        alarm[2] = 1
	    }
	}
	else if global.classiclap && global.lap == 2 
	{
	    global.fill = 0
		if string_startswith(room_get_name(room), "war_")
			instance_create(0, 0, obj_pizzaface)
	    with obj_tv {
	        showtext = true
	        message = "It's SHOWTIME!"
	        alarm[2] = 250
	    }
	}
}
// shit! we need the shit to run
if performance_destroy()
{
	exit;
}