if visible = true && obj_player.state != states.ejected
{
	if place_meeting(x,y-1,obj_player)
		with obj_player
		{
			if state != states.gameover
			{
				if state == states.knightpep
					state = states.knightpepslopes
				else if state != states.knightpepslopes
				{
					state = states.slipnslide
					sprite_index = spr_slipnslide
				}
				if movespeed < 12
					movespeed = 12
			}
		}
}

if visible = false && global.boxhp <= 5
{
	x = xstart 
	y = ystart
	visible = true
	repeat 4 instance_create(x,y,obj_debris)
	scr_soundeffect(sfx_breakblock)
	mask_index = sprite_index
}