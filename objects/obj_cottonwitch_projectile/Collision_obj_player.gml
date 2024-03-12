if !place_meeting(x, y, obj_parryhitbox)
{
	with other
	{
		if character == "V"
			scr_hurtplayer(object_index)
		else
		{
			if scr_transformationcheck() && !hurted && state != states.parry
			{
				state = states.cotton;
				sprite_index = spr_cotton_idle;
		
				scr_soundeffect(sfx_shotgunblast);
				instance_create(x, y, obj_genericpoofeffect);
				
				instance_destroy(other)
			}
		}
	}
}
