var player = other;
with player
{
	if place_meeting(x, y, other) && key_up2 && grounded && vsp >= 0
	&& (state == states.normal or state == states.mach1 or state == states.mach2)
	&& !instance_exists(obj_fadeout)
	{
		if global.pigtotal >= other.price
		{
			scr_soundeffect(sfx_kashing)
			ini_open("saveData" + string(global.saveslot) + ".ini")
			ini_write_real("UnlocksNEW", other.purchase, 1)
			ini_write_real("UnlocksNEW", "spentmoney", ini_read_real("UnlocksNEW", "spentmoney", 0) + other.price)
			ini_close()
			
			with obj_pigtotal
				refresh()
			instance_destroy(other)
		}
		else
			scr_soundeffect(sfx_denied)
	}
}

