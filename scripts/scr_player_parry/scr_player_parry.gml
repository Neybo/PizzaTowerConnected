function scr_player_parry()
{
	landAnim = false;
	if image_index >= image_number - 1
		state = states.normal;

	if movespeed <= 0
		movespeed = 0;
	else if grounded or FINAL_GAMEPLAY
		movespeed -= 0.5;
	
	hsp = movespeed * -xscale;
	
	if grounded && !scr_solid_player(x + hsp, y + 1)
		hsp = 0;
	
	image_speed = 0.5;

	var _grabbedby = 1;
	if parry_count > 0
	{
		var parry_threshold = 128;
		parry_closest = -1
		parry_closest_dist = 9999
		with obj_baddie
		{
			if (distance_to_object(other) < parry_threshold && distance_to_object(other) < 
			other.parry_closest_dist)
			{
				other.parry_closest = id
				other.parry_closest_dist = distance_to_object(other)
			}
		}
		if (parry_closest == -1)
			exit;
		with parry_closest
		{
			if object_index != obj_grandpa && object_index != obj_pizzaballOLD
			&& distance_to_object(other) < parry_threshold && state != states.grabbed 
			&& state != states.hit && state != states.stun 
			&& parryable && !(state == states.stun && thrown) && other.parry_count
			{
				show_debug_message(object_get_name(object_index))
				other.parry_count--;
				if FINAL_GAMEPLAY
					other.xscale = -image_xscale;
				else
					image_xscale = -other.xscale;
				
				if OLD_GAMEPLAY
				{
					hsp = abs(hsp) * -image_xscale;
				
					if hp > 1
						hp = 1;
					grabbedby = _grabbedby;
					state = states.grabbed;
				}
				else
				{
					hp -= 100;
					other.hithsp = ((-other.image_xscale) * 25)
					other.hitvsp = -6
					scr_hitthrow(id, other.id);
					
					repeat 3
					{
						instance_create(x, y, obj_slapstar);
						create_particle(x, y, particles.baddiegibs);
					}
					
					with obj_camera
					{
						shake_mag = 3;
						shake_mag_acc = 3 / room_speed;
					}
				}
			}
		}
	}
}