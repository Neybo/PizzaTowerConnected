if sprite_index == sprgot && obj_player.state != states.gottreasure
	instance_destroy();

if sprite_index != sprgot
	sprite_index = spridle

var pmeet = instance_place(x, y, obj_player);
if pmeet && !instance_exists(player) && pmeet.state != states.gameover
{
	with pmeet
	{
		if grounded
		{
			sprite_index = spr_gottreasure
				
			treasure_x = x
			treasure_y = y
			treasure_room = room
				
			if sprite_index == spr_playerSP_gottreasure
			{
				treasure_x -= 25 * xscale;
				treasure_y -= 20;
			}
			hsp = 0
			vsp = 0
			global.treasure = true;
			
			if other.sprite_index == other.spridle
			{
				other.alarm[0] = 150
				state = states.gottreasure
				scr_soundeffect(sfx_secretfound)
				ds_list_add(global.saveroom, other.id) 
			}
			
			other.sprite_index = other.sprgot
			sprgot = other.sprgot
			other.x = treasure_x
			other.y = treasure_y - 35
			other.player = id
			
			with obj_tv
			{
				showtext = true
				message = "YOU GOT A TOWER SECRET TREASURE!"
				alarm[2] = 200
			}
		} 
	}
}

