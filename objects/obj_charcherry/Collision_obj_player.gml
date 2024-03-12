if (state == states.chase or sprite_index == popoutspr) && !other.cutscene && other.state != states.hit
{
	instance_destroy();
	with other
	{
		if instance_exists(parry_inst)
		{
			with parry_inst
				event_user(0);
		}
		else if state != states.mach3
		{
			instance_create(x, y, obj_playerexplosion);
			if character == "V"
				scr_hurtplayer(id);
			else
			{
				scr_transfobump(false);
			
				image_index = 0;
				vsp = -4;
				sprite_index = spr_bombpepend;
		
				state = states.bombpep;
				bombpeptimer = 0;
			}
		}
	}
}
