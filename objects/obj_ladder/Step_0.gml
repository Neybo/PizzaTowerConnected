var player = instance_place(x, y - 1, obj_player);
with player
{
	if place_meeting(x, y + 1, other) && !scr_solidwall(x, y + 1) && key_down && !key_up && (state == states.crouch or (character = "S" && (state == states.normal or state == states.mach1))) && place_meeting(x, y + 1, obj_platform)
	{
		state = states.ladder
		y = floor(y + 5)
		if y % 2 == 1
			y -= 1
			
		doorx = other.x + 16;
	}
}