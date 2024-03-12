image_speed = 0.35;
sprite_index = choose(spr_gerome_idle1, spr_gerome_idle2, spr_gerome_idle3);

die = (FINAL_GAMEPLAY && string_endswith(string_replace(room_get_name(room), "_NEW", ""), "_1"))
	or global.snickchallenge 
	or (OLD_GAMEPLAY && !string_endswith(string_replace(room_get_name(room), "_NEW", ""), "_1"))

with obj_player
	if character == "S" instance_destroy(other.id);
