if !instance_exists(ID)
	instance_destroy()

if instance_exists(ID)
{
	x = ID.x;
	y = ID.y;
	if scr_solidwall(x, y)
		x = -9999;
	
	image_xscale = ID.image_xscale;
	image_index = ID.image_index;
	
	if ID.object_index == obj_smurfknight
		x += ID.image_xscale * 10;
	if ID.object_index == obj_sausageman
		y -= 20;
	
	if object_get_parent(ID.object_index) == obj_baddie && ID.rematchscare
	{
		ID.hitboxcreate = false;
		instance_destroy();
	}
	else
	{
		with ID
		{
			if object_index == obj_coolpineapple
			or object_index == obj_forknight
			or object_index == obj_smurfknight
			or object_index == obj_indiancheese
			or object_index == obj_noisey
			or object_index == obj_sausageman
			{
				if state != states.walk && state != states.rage
				{
					hitboxcreate = false
					instance_destroy(other)
				}
			}
			
			if object_index == obj_robot
			{
				if state != states.mach2 && state != states.slap && state != states.tackle
				{
					hitboxcreate = false
					instance_destroy(other)
				}
				else if state != states.slap
					other.x = x + image_xscale * 32
			}
			
			if object_index == obj_soldier
			{
				other.x = x + image_xscale * 24
				if state != states.rage
					instance_destroy(other)
			}
			
			if object_index == obj_weeniesquire
			{
				if stun
				{
					hitboxcreate = false
					instance_destroy(other)
				}
			}
			
			if object_index == obj_boulder
			{
				if hitwall = false
					instance_destroy(other)
			}

			//SAGE2019
			if object_index == obj_snickexe or object_index == obj_snickexg 
			or object_index == obj_snickexi
			{
				var player = instance_nearest(x, y, obj_player)
				if player && (player.instakillmove or player.state == states.handstandjump 
				or player.state == states.punch)
				{
					instance_destroy(other)
					hitboxcreate = false
				}
			}
			
			if object_index == obj_pickle
			{
				if state != states.pizzagoblinthrow
					instance_destroy(other)
			}
			
			if object_index == obj_noisecrusher
			{
				if state != states.bounce
				{
					hitboxcreate = false
					instance_destroy(other)
				}
			}

			if object_index == obj_peasanto
			or object_index == obj_fencer
			or object_index == obj_bananacharger
			or (object_index == obj_ninja && OLD_GAMEPLAY)
			or object_index == obj_pizzice
			or object_index == obj_ancho
			{
				if (state != states.charge && state != states.rage)
				or (obj_player.state == states.handstandjump && OLD_GAMEPLAY)
				{
					hitboxcreate = false
					instance_destroy(other)
				}
			}
			else if object_index == obj_ninja
			{
				if state != states.charge && state != states.punch
					instance_destroy(other)
				if state == states.punch
				{
					if image_index > 14
						instance_destroy(other)
					other.x = x + image_xscale * 24
				}
			}

			if object_index == obj_fencer
			{
				if state != states.walk && state != states.charge
				{
					hitboxcreate = false
					instance_destroy(other)
				}
			}
			
			if object_index == obj_thug_red
			or object_index == obj_thug_blue
			or object_index == obj_thug_green
			{
				if state != states.punch
				{
					instance_destroy(other);
					punchinst = noone;
				}
			}
			
			if object_index == obj_minijohn
			{
				if state != states.rage && state != states.punch
					instance_destroy(other);
			}
		}
	}
}

