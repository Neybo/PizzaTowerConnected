    with (instance_create(x, y, obj_explosioneffect))
    {
        sprite_index = spr_bombexplosion
        image_speed = 0.35
    }
	gp_vibration(1,1,0.9)
	scr_soundeffect(sfx_explosion)
    with (baddieID)
    {
        if (bombreset > 20)
            bombreset = 20
		bazookaID = -4
	}

