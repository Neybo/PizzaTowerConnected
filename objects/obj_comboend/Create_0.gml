image_speed = 0.35
combo = 0
comboscore = 0
combominus = 0
timer_max = 1
timer = 0
title_index = 0
depth = obj_particlesystem.depth - 1
alarm[0] = 1
sugary = false

with obj_player
{
    if !place_meeting(x, y, obj_exitgate)
        global.combodropped = true
	
	if character == "SP"
		other.sugary = true;
}
global.combo = 0
