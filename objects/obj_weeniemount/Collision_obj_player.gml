
with other
{
	if state == states.handstandjump or state == states.punch
	{
		if !string_startswith(room_get_name(room), "saloon") && room != tower_escape5
		{
			state =	states.rideweenie		
			sprite_index = spr_rideweenie
			xscale = other.image_xscale
			vsp = -11
			jumpstop = true
			movespeed = 0
			grounded = false
			with instance_create(x,y,obj_jumpdust)
				image_xscale = other.xscale
			instance_destroy(other)
		}
		else
		{
			scr_soundeffect(sfx_weeniestart)
			state = states.newweenieriding;
			movespeed = hsp;
			sprite_index = spr_rideweenie;
			xscale = other.image_xscale;
			dir = xscale;
			jumpstop = true;
			if (vsp < 0)
				vsp = 0;
			instance_destroy(other);
			tv_push_prompt_once(tv_create_prompt("This is the weenie transformation text", 2,
			spr_tv_exprcollect, 3), "weenie");
		}
	}
}