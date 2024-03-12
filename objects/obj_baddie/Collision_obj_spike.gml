if state != states.grabbed && state != states.hit && other.object_index != obj_rematchplug 
&& !string_startswith(room_get_name(room), "d2")
	instance_destroy();