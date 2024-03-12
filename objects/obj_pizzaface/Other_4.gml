x = room_width / 2
y = -100
if FINAL_GAMEPLAY
{
	x = obj_player.x
	y = obj_player.y
	image_alpha = 0;
}

if sugary && !global.classiclap
	reset_pos();

var nerf_room = (room == entrance_6c or room == entrance_6c_NEW 
or room == oldsewer_3 or room == oldsewer_3_NEW or room == oldfreezer_3)

if nerf_room
{
	maxspeed = 4
	if !sugary
		sprite_index = spr_pizzaface_haywire
}
else
{
	maxspeed = 8
	if !sugary && finalbehavior
		sprite_index = spr_pizzaface_NEW
	else if !finalbehavior
		sprite_index = spr_pizzaface_NEW
}
if room == rank_room
	instance_destroy(id)

