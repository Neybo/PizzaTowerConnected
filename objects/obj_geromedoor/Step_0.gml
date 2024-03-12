if place_meeting(x, y, obj_player) && image_index == 0 && obj_player.key_up 
&& obj_player.grounded && global.gerome
&& (obj_player.state == states.normal or obj_player.state == states.mach1 
or obj_player.state == states.pogo or obj_player.state = states.mach2 
or obj_player.state == states.mach3 or obj_player.state == states.Sjumpprep)
{
	ds_list_add(global.saveroom, id)
	
	with obj_camera
	{
		alarm[1] = -1;
		alarm[3] = -1;
	}
		
	with obj_player
	{
		state = states.victory
		doorx = other.x + 50
		keydoor = true
		
		image_index = 0
		targetRoom = other.targetRoom;
		targetDoor = other.targetDoor;
	}
	
	with obj_geromefollow
		visible = false;
	with instance_create(obj_player.x - 30, obj_player.y, obj_geromeanim)
	{
		sprite_index = spr_gerome_opendoor;
		image_index = 0;
		image_speed = 0.35;
	}
	
	image_index = 1;
	global.gerome = false;
	instance_destroy(obj_pizzaface);
}

if place_meeting(x, y, obj_player) && floor(obj_player.image_index) >= obj_player.image_number - 1 
&& obj_player.state == states.victory
{
	with obj_player
	{
		targetDoor = other.targetDoor
		targetRoom = other.targetRoom
		
		if !instance_exists(obj_fadeout)
		{
			scr_soundeffect(sfx_door)
			instance_create(x,y,obj_fadeout)
		}
	}
}
if room == d2factory_13
{
	visible = true
	depth = -1
}