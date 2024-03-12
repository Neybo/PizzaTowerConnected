if instance_exists(baddieID) && baddieID.state != states.grabbed && baddieID.state != states.hit
&& !baddieID.invincible && baddieID.instantkillable
{
	if OLD_GAMEPLAY
	{
		instance_destroy()
		instance_destroy(baddieID)
	}
	else
	{
		scr_soundeffect(sfx_punch);
		baddieID.hp -= 99;
		baddieID.image_xscale = -other.image_xscale;
		baddieID.hitvsp = -8;
		baddieID.hithsp = other.image_xscale * 15;
		scr_hitthrow(baddieID, noone, 8);
		baddieID.invtime = 25;
	}
}
