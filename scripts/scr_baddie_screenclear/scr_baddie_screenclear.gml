function scr_baddie_screenclear()
{
	with obj_baddie
	{
		if instance_in_camera(id, view_camera[0])
		&& object_index != obj_pizzaballOLD && object_index != obj_grandpa && object_index != obj_charcherry
		{
			if OLD_GAMEPLAY
				instance_destroy();
			else
			{
				
				if hp <= 0
					instance_destroy();
				else
				{
					hp = 0;
					state = states.hit;
					hitLag = 20;
					hitX = x;
					hitY = y;
						
					instance_create(x, y, obj_parryeffect);
					alarm[3] = 3;
						
					repeat 3
					{
						instance_create(x, y, obj_slapstar);
						create_particle(x, y, particles.baddiegibs);
					}
				}
			}
		}
	}
	with obj_snickexe
	{
		if point_in_camera(x, y, view_camera[0])
		{
			if global.snickrematch
			{
				repeat 6 with instance_create(x + random_range(-100, 100), y + random_range(-100, 100), obj_balloonpop)
					sprite_index = spr_shotgunimpact
						
				deactivate = true;
				alarm[1] = room_speed * 5;
			}
			else
				event_perform(ev_alarm, 0);
		}
	}
}