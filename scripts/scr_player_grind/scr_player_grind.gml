function scr_player_grind() {
	sprite_index = spr_grind;
	image_speed = 0.35;
	machhitAnim = false;
	crouchslideAnim = true;
	hsp = xscale * movespeed;
	
	if (movespeed < 10)
		movespeed = Approach(movespeed, 10, 0.5);
	if ((!place_meeting(x, y + 18, obj_grindrail) && !place_meeting(x, y + 18, obj_grindrailslope)) || place_meeting(x + xscale, y + 4, obj_solid))
	{
		if (movespeed < 12)
		{
			state = states.mach2;
			sprite_index = spr_mach2jump;
		}
		else
		{
			state = states.mach3;
			sprite_index = spr_mach4;
		}
		vsp = -1
	}
	if (place_meeting(x + xscale, y, obj_solid))
	&& (!place_meeting(x, y + 1, obj_slope) && !place_meeting(x, y + 18, obj_grindrailslope))
	{
		state = states.bump;
		hsp = -xscale * 5;
		vsp = 1;
	}
	if (key_jump)
	{
		with (instance_create(x, y, obj_jumpdust))
			image_xscale = other.xscale;
		vsp = -11;
		jumpstop = false;
		if (movespeed < 12)
		{
			state = states.mach2;
			sprite_index = spr_mach2jump;
		}
		else
		{
			state = states.mach3;
			sprite_index = spr_mach3jump;
		}
	}
	if (!instance_exists(obj_grindeffect))
		instance_create(x, y - 18, obj_grindeffect);

}
