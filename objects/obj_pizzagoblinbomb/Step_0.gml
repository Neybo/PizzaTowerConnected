countdown -= 0.5
if place_meeting(x + 1, y, obj_bombblock) or place_meeting(x - 1, y, obj_bombblock) 
or place_meeting(x, y - 1, obj_bombblock) or place_meeting(x, y + 1, obj_bombblock)
{
	instance_create(x, y, obj_bombexplosion)
	instance_destroy()
	exit
}

if scr_solid(x + hsp, y)
	drop = true
if scr_solid(x, y + 1)
	hsp = 0

if vsp < 12 vsp += grav;

var railmeet = instance_place(x, y + 1, obj_railparent);
if railmeet then hsp = railmeet.spdh;

if countdown < 50
	sprite_index = spr_bomblit
if countdown <= 0
	instance_create(x, y, obj_bombexplosion)

scr_collide()

