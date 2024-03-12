function scr_player_victory()
{
	hsp = 0

	mach2 = 0
	jumpAnim = true
	dashAnim = true
	landAnim = false
	moveAnim = true
	stopAnim = true
	crouchslideAnim = true
	crouchAnim = true
	machhitAnim = false

	if place_meeting(x, y, obj_keydoor)
	or place_meeting(x, y, obj_geromedoor)
	{
		sprite_index = spr_victory;
		
		if REMIX_GAMEPLAY
		{
			x = Approach(x, doorx, 6);
			if x != xprevious
				xscale = sign(x - xprevious);
		}
	}
	
	if floor(image_index) >= image_number -1
		image_speed = 0;
	else
		image_speed = 0.35;
	
	if place_meeting(x, y, obj_startgate) && REMIX_GAMEPLAY
	{
		x = Approach(x, doorx, 10);
		if x != xprevious
		{
			xscale = sign(x - xprevious);
			if image_index >= 2
				image_speed = 0;
		}
	}
}