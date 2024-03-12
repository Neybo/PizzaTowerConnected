with obj_player
{
	if sign(other.image_yscale) == 1
	{
		if (((key_down && !place_meeting(x, y + 1, obj_destructibles) && place_meeting(x, y + 1, other) && ((state == states.crouch || state == states.machroll || (state == states.tumble && sprite_index == spr_dive))) || ((state == states.crouchslide || (state == states.tumble && key_down) || state == states.freefall || state == states.freefallland) && !place_meeting(x, y + 1, obj_destructibles) && place_meeting(x, y + 1, other))) && !instance_exists(obj_fadeout) && state != states.door && state != states.comingoutdoor)
		or (state == states.crouchslide or state == states.freefall or state == states.freefallland)
		or (sprite_index == spr_machroll && grounded) or sprite_index == spr_dive)
		&& !instance_exists(obj_fadeout) && !place_meeting(x, y + 1, obj_destructibles) && place_meeting(x, y + 1, other) && state != states.gameover && state != states.hitlag
			other.downbox(id, other);
	}
	if sign(other.image_yscale) == -1
	{
		if ((key_up && (state == states.normal or state == states.pogo or state == states.jump or state == states.mach1 or state == states.mach2 or state == states.mach3 or state == states.Sjumpprep or (state == states.punch && sprite_index == spr_breakdanceuppercut))) or ((state == states.Sjump or state == states.Sjumpland))) 
		&& !instance_exists(obj_fadeout) && !place_meeting(x, y - 1, obj_destructibles) && place_meeting(x, y - 10, other) && state != states.gameover && state != states.hitlag
			other.upbox(id, other);
	}
}
