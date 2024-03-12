function create_collect(x, y, sprite, arg_combo = false, skip_gameplay = false)
{
	if OLD_GAMEPLAY && !skip_gameplay
		exit;
	
	with instance_create(x - camera_get_view_x(view_camera[0]), y - camera_get_view_y(view_camera[0]),
	obj_collectparticle)
	{
		sprite_index = sprite;
		combo = arg_combo
		
		if sprite == other.sprite_index
		{
			image_speed = other.image_speed;
			image_index = other.image_index;
		}
	}
}

function create_baddiegibsticks(x, y)
{
	if OLD_GAMEPLAY
		exit;
	
	with instance_create(x, y, obj_baddiegibsstick)
	{
		image_xscale = abs(other.image_xscale);
		image_yscale = abs(other.image_yscale);
	}
}

function create_particle(x, y, par)
{
	enum particles
	{
		baddiegibs,
	}
	
	switch par
	{
		case particles.baddiegibs:
			var bad = id;
			if bad == obj_baddiecollisionbox
				bad = bad.baddieID;
			
			if instance_exists(bad) && bad.object_index != obj_robot && bad.object_index != obj_cheeserobot
			{
				with instance_create(x, y, obj_baddiegibs)
				{
					if (inst_relation(bad, obj_baddie) && bad.sugaryenemy)
					or (bad.sprite_index == spr_hungrypillar_ss)
					{
						sprite_index = spr_baddiegibs_ss;
						image_index = irandom_range(0, image_number - 1);
						angspd = random(2);
						hsp = random_range(-10, 10);
					}
					if bad.object_index == obj_pizzice
					{
						sprite_index = OLD_GAMEPLAY ? spr_pizzice_gibs : spr_newpizzice_gibs;
						image_index = irandom_range(0, image_number - 1);
					}
				}
			}
			break;
	}
}

