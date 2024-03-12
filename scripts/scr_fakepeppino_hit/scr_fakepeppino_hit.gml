// now unused
function scr_fakepeppino_hit()
{
	hsp = image_xscale * movespeed

	//Grab player
	var player = instance_place(x, y, obj_player);
	if player && player.state != states.gameover
	{
		with player
		{
			if state != states.hurt && !hurted && !cutscene && state != states.bump && state != states.hitlag
			{
				if state != states.backbreaker
				{
					scr_transfobump()
					state = states.backbreaker
					sprite_index = spr_hurt
					x = other.x + (other.image_xscale * 50)
					y = other.y
				}
				with other
				{
					if sprite_index != spr_fakepeppino_grabattack
					{
						image_index = 0
						sprite_index = spr_fakepeppino_grabattack
						movespeed = 0
					}
				}
			}
		}
	}
	
	if floor(image_index) >= image_number - 1 && sprite_index == spr_fakepeppino_grabdash
	{
		state = states.idle
		image_index = 0
		sprite_index = spr_fakepeppino_idle
		movespeed = 0
	}

	//Attack
	if sprite_index == spr_fakepeppino_grabattack && floor(image_index) == 4
	{
		state = states.idle
		scr_hurtplayer(obj_player);
	}
	
	if sprite_index == spr_fakepeppino_grabattack && floor(image_index) >= image_number - 1
	{
		state = states.idle
		sprite_index = spr_fakepeppino_idle
		image_index = 0
	}
}

