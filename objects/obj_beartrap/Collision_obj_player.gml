if other.state != states.bossintro
{
	with instance_create(x, y - 75, obj_press)
		ID = other.id
}

with other
{
	hsp = 0
	if !other.drop
	{
		scr_soundeffect(sfx_pephurt);
		
		if state != states.bossintro
		{
			sprite_index = spr_hurt
			instance_create(x, y, obj_spikehurteffect)
		}
		
		if key_jump or key_attack2 or key_slap2
		{
			if grounded
			{
				scr_soundeffect(sfx_jump)
				instance_create(x, y, obj_highjumpcloud2)
				vsp = -4
				other.press += 2
			}
		}
		
		state = states.bossintro
	}
}

if floor(image_index) == 0
	image_speed = 0.35

if floor(image_index) >= image_number - 1
	image_speed = 0

if press < 8
	closed = true
