image_speed = 0.5
hsp = 0
vsp = random_range(-2,-4)
grav = 0.5

with obj_player
	if character == "S" instance_destroy(other);
if string_startswith(room_get_name(room), "d2factory_")
	instance_destroy();