hsp = image_xscale * movespeed
mask_index = spr_player_mask

if scr_solid(x, y + 1) && vsp > 0
{
	vsp = -5
	if movespeed > 0
		movespeed -= 1
}

if obj_player.key_shoot2 && obj_player.state != states.dynamite && obj_player.character == "V"
	instance_destroy()

if scr_solidwall(x + hsp, y)
	image_xscale *= -1

if place_meeting(x + hsp, y + vsp, obj_destructibles)
or place_meeting(x + hsp, y + vsp, obj_metalblockescape)
or place_meeting(x + hsp, y + vsp, obj_metalblock)
or place_meeting(x, y, obj_baddie)
or place_meeting(x + hsp, y + vsp, obj_cheeseballblock)
or place_meeting(x + hsp, y + vsp, obj_pizzaballblock)
or place_meeting(x + hsp, y + vsp, obj_bombblock)
	instance_destroy()

if countdown <= 0
	instance_destroy()

//Flash 
if sprite_index == spr_dynamite && countdown < 120 / 2
	sprite_index = spr_dynamiteabouttoexplode

//Countdown for explosion
if sprite_index == spr_dynamite or sprite_index == spr_dynamiteabouttoexplode
	countdown--

scr_collide()
