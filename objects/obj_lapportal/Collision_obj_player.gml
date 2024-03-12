if (global.panic || global.wartimer) {
	instance_create_unique(0, 0, obj_lap2visual)
    if (other.state != states.portal) {
        scr_soundeffect(sfx_lapenter)

        other.sprite_index = other.spr_fall
        other.movespeed = 0
        other.hsp = 0
        sprite_index = other.spr_portalenter
        image_index = 0
        other.state = states.portal
        other.grav = 0
        other.visible = false
        global.collect += 2000;
        global.lap++;
        global.lap2 = true
		if global.leveltosave == "exit"
		{
			if !global.classiclap
			{
				if OLD_GAMEPLAY
					targetTime = 332 - (global.minutes * 60 + global.seconds)
				else
					targetTime = 4000 - global.fill 
			}
			else if global.fill > 0
				global.fill = 4000
		}
		if OLD_GAMEPLAY && !global.classiclap
			targetTime = global.seconds + timetoadd
        else if !global.classiclap
            targetTime = global.fill + (timetoadd * 12) // 12 = a second
        if global.lap >= 2 && global.wartimer && string_startswith(room_get_name(room), "war") {
            scr_soundeffect(sfx_warup)
            with(obj_wartimer) {
                addseconds += 180
                alarm[0] = -1
                alarm[2] = 1
            }
        }

        if (global.lap == 99) {
            instance_create_unique(room_width / 2, -50, obj_snickexe);
            with obj_tv {
                showtext = true
                message = "good luck."
                alarm[2] = 250
            }
            if (check_online())
                jba_global("Lap 100!", gms_self_name() + " has just reached lap 100 on " + scr_levelnamenice() + "!", globalembeds.lap100)
        }
        if (global.lap == 199) {
            instance_create(room_width / 2, -50, obj_snickexi);
            instance_create(room_width / 2, -50, obj_snickexg);
            instance_create(room_width / 2, -50, obj_snickexf);
            with obj_tv {
                showtext = true
                message = "enough."
                alarm[2] = 250
            }
            if (check_online())
                jba_global("Lap 200!", gms_self_name() + " has just reached lap 200 on " + scr_levelnamenice() + "! Wow!", globalembeds.lap200)
        }
    }
    global.combotime = 60;
    if (timetoadd == 0) {
        global.seconds = 0
        global.fill = 0;
        global.minutes = 0
    }
    if (global.lap2 && global.lap > 1) && !global.classiclap // inf lapping
    {
        if (OLD_GAMEPLAY) {
            global.seconds = Approach(global.seconds, targetTime, (timetoadd + 10) / 100);
			if global.seconds > 60
			{
				global.minutes++
				global.seconds = 0
			}
		} else {
            global.fill = Approach(global.fill, targetTime, (timetoadd + 20) / 10);
        }
    }
}