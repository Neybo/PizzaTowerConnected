var player = other;
var gate = id;
with player
{
	if place_meeting(x, y, other) && key_up && grounded && vsp >= 0
	&& (state == states.normal or state == states.mach1 or state == states.mach2)
	&& !instance_exists(obj_fadeout)
	{
		if (!scr_checkskin(checkskin.p_anton)
		or (other.level == "snickchallenge" or other.level == "snickrematch" or other.level == "grinch")
		or room == hub_roomPLN)
		&& !global.panic && !fmod_is_instance_playing(global.jukebox)
			fmod_stop_instance_immediately(global.music);
		
		// snap to ground just in case
		for(var i = 0; i < 8; i++)
		{
			if scr_solid(x, y + i + 1)
			{
				y += i;
				break;
			}
		}
		
		mach2 = 0
		obj_camera.chargecamera = 0;
		obj_camera.crouchcamera = 0;
		image_index = 0
		state = states.victory
		global.combotime = 0
		
		doorx = other.x;
		if other.short
			sprite_index = spr_lookdoor
		else
			sprite_index = spr_entergate
	}
}

if floor(player.image_index) >= player.image_number - 1 && player.state == states.victory
{
	myturn = true;
	global.leveltosave = oglevel
	global.snickchallenge = string_contains(oglevel, "snick")
	global.snickrematch = oglevel == "snickrematch" || string_contains(oglevel, "_re")
		
	backtohubstartx = other.x
	backtohubstarty = y
	backtohubroom = room
	
	with player
	{
		targetDoor = other.targetDoor
		targetRoom = other.targetRoom
		
		global.pizzacoinstart = global.pizzacoin
		if !instance_exists(obj_fadeout) && other.notitle
			instance_create(x, y, obj_fadeout);
		else
		{
		if (!instance_exists(obj_titlecard))
			{
				with (instance_create(x, y, obj_titlecard))
					{
						titlecard_sprite = gate.titlecard_sprite;
						titlecard_index = gate.titlecard_index;
						title_sprite = gate.title_sprite;
						title_index = gate.title_index;
						title_music = gate.title_music;
					}
			}
		}
		scr_prankreset(string_contains(other.oglevel, "snick"), other.oglevel)
	}
}

