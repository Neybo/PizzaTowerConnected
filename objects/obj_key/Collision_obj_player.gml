if other.state == states.gameover exit;

with other
{
	if place_meeting(x,y,other)
	if state != states.bombpep && state != states.ghost && state != states.knightpep && state != states.cheeseball && state != states.boxxedpep && state != states.cheesepep && state != states.knightpepattack && state != states.knightpepslopes && state != states.hurt
	{
		global.heattime = 60;
		
		instance_destroy(other)
		global.key_inv += 1
		key_particles = true
		alarm[7] = 30
		
		scr_soundeffect(sfx_collecttoppin)
		state = states.keyget
		image_index = 0
		
		if other.sprite_index == spr_key_ss
			sprite_index = spr_keyget_ss
		
		if room == oldmansion_pepperman
			instance_destroy(obj_peppermandestroyable);
	}
}

