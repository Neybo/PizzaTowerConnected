with obj_player
{
	if state == states.bombpep && sprite_index != spr_bombpepend
	&& (place_meeting(x + xscale, y + 1, other) or place_meeting(x + xscale, y - 1, other))
	{
		gp_vibration(1, 1, 0.9);
		instance_destroy(other)
		instance_create(x, y, obj_bombexplosion)
		hurted = true
		vsp = -4
		image_index = 0
		sprite_index = spr_bombpepend
		state = states.bombpep
		bombpeptimer = 0
	}
}
image_alpha = place_meeting(x, y, obj_otherplayer) ? 0.5 : 1;

