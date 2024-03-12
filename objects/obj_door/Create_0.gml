if global.panic && string_startswith(room_get_name(room), "tower_")
	instance_destroy();

image_speed = 0.35
visited = false

depth = 3;
if scr_depthcheck()
	depth += 100;

targetDoor = "A"
targetRoom = room

john = false

if check_sugary()
	sprite_index = spr_doorunvisited_ss

