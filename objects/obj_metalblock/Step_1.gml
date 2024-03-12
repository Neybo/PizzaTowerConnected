with obj_player
{
	// mach3 break
	if (character != "V" || FINAL_GAMEPLAY)
	&& (place_meeting(x + hsp, y, other) or place_meeting(x + xscale, y, other))
	&& (state == states.mach3 or state == states.rocket or state == states.knightpepslopes 
	or state == states.slipbanan or state == states.chainsaw
	or (state == states.punch && sprite_index == spr_superjumpcancel))
	{
		if REMIX_GAMEPLAY
			other.momentum[0] = hsp;
		instance_destroy(other);
	}
	
	// body slam
	if place_meeting(x, y + 1, other) && ((state == states.freefall && freefallsmash >= 10)
	or state == states.knightpep or state == states.slipbanan)
	{
		other.momentum[1] = vsp;
		instance_destroy(other);
	}
}
