rank = "none"
levelsign = "none"

image_speed = 0
depth = 49 + floor((room_height - y) / 64); // lower signs are in front

if check_sugary()
	sprite_index = spr_ranksign_ss;

if global.panic && string_startswith(room_get_name(room), "tower_") && room != tower_entrancehall
	instance_destroy()
