var nearest = instance_nearest(x, y, obj_player);
if !activated
{
	if nearest.x < x + 100 && nearest.x >= x - 100 && nearest.y > y
	{
		grav = 0.5
		activated = true
		image_speed = 0.35
		if FINAL_GAMEPLAY
			sprite_index = spr_meatball_roll
	}
}
else
{
	var player = instance_place(x, y, obj_player);
	if player && activated && !hitwall
	{
		with player
		{
			if player.state != states.stunned && scr_transformationcheck() && grounded
			{
				if place_meeting(x, y + 1, obj_platform) && !scr_solidwall(x, y + 1)
					y += 1
			
				state = states.stunned
				tv_push_prompt_once(tv_create_prompt("This is the squished transformation text", 2, spr_tv_squished, 3), "squished")
				sprite_index = spr_squished
				image_index = 0
			}
		}
	}

	if vsp > 0 && scr_solid(x, y + 1)
	{
		if FINAL_GAMEPLAY
			vsp = -6
		hsp = image_xscale * 8
	}
	
	var des = instance_place(x + hsp, y, obj_destructibles);
	with des
		instance_destroy()

	if !des && scr_solidwall(x + hsp, y) && activated && !place_meeting(x + hsp, y, obj_slope) && !hitwall && scr_solid(x, y + 1)
	{
		with instance_create(x, y, obj_sausageman_dead)
		{
			sprite_index = spr_noiseboulder
			if FINAL_GAMEPLAY
				sprite_index = spr_meatball_dead
		}
		instance_destroy()
	}
}
if !hitwall
	scr_collide()

