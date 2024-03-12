image_speed = 0.35;
depth = 4;

targetRoom = room;
targetDoor = "A";

if obj_player.character == "N" && REMIX_GAMEPLAY
	sprite_index = spr_boxofpizzaN
if check_sugary()
{
	sprite_index = spr_boxofpizzaSP
	mask_index = sprite_index
}

if string_startswith(room_get_name(room), "strongcold")
	sprite_index = spr_xmaspizzaboxdown
if global.snickrematch
	sprite_index = spr_boxofpizza_re

downbox = function(player, pbox)
{
	scr_soundeffect(sfx_box);
	pbox.depth = -10;
	pbox.enter = true;
	
	with obj_camera
		chargecamera = 0;
	
	with player
	{
		vsp = 0;
		state = states.door;
		box = true;
		mach2 = 0;
		
		sprite_index = spr_downpizzabox;
		image_index = 0;
		
		targetRoom = pbox.targetRoom;
		targetDoor = pbox.targetDoor;
		
		doorx = pbox.x;
		if NOT_REMIX_GAMEPLAY
			x = doorx;
	}
}
upbox = function(player, pbox)
{
	scr_soundeffect(sfx_box);
	pbox.depth = -10;
	pbox.enter = true;
	
	with obj_camera
		chargecamera = 0;
	
	with player
	{
		vsp = 0;
		state = states.door;
		box = true;
		mach2 = 0;
		
		sprite_index = spr_uppizzabox;
		image_index = 0;
		
		targetDoor = pbox.targetDoor;
		targetRoom = pbox.targetRoom;
		
		doorx = pbox.x;
		x = doorx;
		y = pbox.y + 24;
	}
}
