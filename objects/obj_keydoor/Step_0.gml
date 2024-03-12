var player = instance_place(x, y, obj_player);
if player
{
	// unlock door
	if player.key_up && player.grounded && global.key_inv > 0 && sprite_index == spr_locked
	&& (player.state == states.normal or player.state == states.mach1 or player.state == states.pogo or player.state == states.mach2 or player.state == states.mach3 or player.state == states.Sjumpprep)
	{
		if REMIX_GAMEPLAY
			scr_soundeffect(sfx_unlockdoor)
		ds_list_add(global.saveroom, id)
	
		with player
		{
			state = states.victory
			image_index = 0
			keydoor = true
			doorx = other.x + 50
		}
		
		with instance_create(x + 50, y + 50, obj_lock)
			sprite_index = other.lockspr
		
		image_index = 0
		sprite_index = spr_opening
		
		image_speed = 0.35
		global.key_inv -= 1
	}
	
	// travel
	if floor(player.image_index) >= player.image_number - 1 && player.state == states.victory
	{
		with player
		{
			targetDoor = other.targetDoor
			targetRoom = other.targetRoom
		
			if !instance_exists(obj_fadeout)
			{
				if REMIX_GAMEPLAY
					scr_soundeffect(sfx_door)
				instance_create(x, y, obj_fadeout)
			}
		}
	}
}
if sprite_index == spr_opening && floor(image_index) >= 2
	sprite_index = spr_open
