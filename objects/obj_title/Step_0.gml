/// @description
if vsp < 20
	vsp += grav;
y += vsp;

if y >= ystart
{
	y = ystart;
	if !grounded
	{
		if !(instance_exists(obj_manual) && obj_manual.open) 
		&& !instance_exists(obj_option) && !instance_exists(obj_erasegame)
		{
			scr_soundeffect(sfx_breakblock)
			with obj_camera
			{
				shake_mag = 6;
				shake_mag_acc = 6 / room_speed;
			}
		}
		
		grounded = true;
		vsp = -6;
		repeat 9
			instance_create(irandom_range(bbox_left, bbox_right), bbox_bottom, obj_debris);
		
		if object_index == obj_title
		{
			with obj_player
			{
				state = states.backbreaker;
				sprite_index = spr_bossintro;
				image_index = 0;
				image_speed = 0.35;
				vsp = -4;
			}
		}
	}
	else
	{
		grav = 0;
		vsp = 0;
	}
}
with obj_drpc_updater
	det = "In the titlescreen"
// background
if object_index == obj_title
{
	var lay_id = layer_get_id("Backgrounds_1");
	var back_id = layer_background_get_id(lay_id);
	
	
		with obj_player
		{
			if x <= 242
				layer_background_index(back_id, 0);
		
			if x >= 352 && x <= 562
				layer_background_index(back_id, 1);
		
			if x >= 704
				layer_background_index(back_id, 2);
		}
	
}

