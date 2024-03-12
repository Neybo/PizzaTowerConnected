scr_collide();

if !grounded
	sprite_index = spr_juicepuddleair;
else
{
	if sprite_index == spr_juicepuddleair
	{
		image_index = 0;
		sprite_index = spr_juicepuddlesplash;
	}
	if sprite_index == spr_juicepuddlesplash && image_index >= image_number - 1
		sprite_index = spr_juicepuddledone;
	
	img_angle = 0;
	
	var slope = instance_place(x, y + 1, obj_slope);
	if slope with slope
	{
		var m = sign(image_xscale) * (bbox_bottom - bbox_top) / (bbox_right - bbox_left);
		other.img_angle = 45 * m;
	}
	if place_meeting(x, y + 1, obj_solid)
		img_angle /= 2;
	
	var player = instance_place(x, y, obj_player);
	if player
	{
		with player
		{
			if (scr_transformationcheck() || state == states.tumble) && grounded && vsp >= 0
			{
				if OLD_GAMEPLAY
				{
					if state != states.slipnslide
					{
						sprite_index = spr_slipnslide
						state = states.slipnslide
						if movespeed < 12
							movespeed = 12
					}
				}
				else
				{
					scr_soundeffect(sfx_tumble2)
					sprite_index = spr_slipbanan1;
					vsp = -11;
					image_index = 0;
					movespeed += 2;
					if movespeed > 14
						movespeed = 14;
					state = states.slipbanan;
				}
				instance_destroy(other);
			}
		}
	}
}

