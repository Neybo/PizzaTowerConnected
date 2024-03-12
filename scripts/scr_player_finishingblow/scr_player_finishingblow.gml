function scr_player_finishingblow()
{
	if OLD_GAMEPLAY
	{
		hsp = 0
		vsp = 0
	}
	else
	{
		hsp = movespeed
	    move = key_right + key_left
	    if floor(image_index) < 6 && sprite_index != spr_swingdingend
	        movespeed = Approach(movespeed, 0, 0.25)
	    else
	        movespeed = Approach(movespeed, move * 10, 0.5)
	}

	if floor(image_index) >= image_number - 1
	{
		movespeed = abs(movespeed)
		state = states.normal
	}
	
	if floor(image_index) == 4 && FINAL_GAMEPLAY
		image_index += 2;
	
	if (floor(image_index) >= 6 or FINAL_GAMEPLAY) && !instance_exists(obj_swordhitbox)
	{
		if instance_exists(baddiegrabbedID) && baddiegrabbedID.object_index == obj_junk 
		&& scr_checkskin(checkskin.p_anton)
			scr_soundeffect(sfx_punchball_throw);
		
		scr_soundeffect(sfx_punch)
		scr_soundeffect(sfx_killingblow)
		gp_vibration(0.8, 0.8, 0.65);
	
		with instance_create(x, y, obj_swordhitbox)
			playerid = other.object_index
	}
	
	if floor(image_index) == 0 && !instance_exists(obj_swordhitbox) && sprite_index == spr_swingdingend
	{
		if instance_exists(baddiegrabbedID) && baddiegrabbedID.object_index == obj_junk 
		&& scr_checkskin(checkskin.p_anton)
			scr_soundeffect(sfx_punchball_throw);
	
		scr_soundeffect(sfx_killingblow)
		gp_vibration(0.8, 0.8, 0.65);
	
		with instance_create(x, y, obj_swordhitbox)
			playerid = other.object_index
	}
	
	if !instance_exists(obj_dashcloud2) && grounded && abs(hsp) > 3
    {
        with instance_create(x, y, obj_dashcloud2)
            image_xscale = other.xscale
    }
	
	if FINAL_GAMEPLAY
	{
		if punch_afterimage > 0
			punch_afterimage--
		else
		{
			punch_afterimage = 5
			with instance_create(x, y, obj_mach3effect)
			{
				sprite_index = other.sprite_index
				image_index = other.image_index
				image_xscale = other.xscale
			}
		}
	}
	
	image_speed = 0.4;
	if OLD_GAMEPLAY
		image_speed = 0.35;
	landAnim = false
}

