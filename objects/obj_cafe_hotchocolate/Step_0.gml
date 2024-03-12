if !nodog || obj_dogmount.visible 
	exit;
var player = instance_place(x, y - 1, obj_player)
if player
{
	with player
	{				
		with instance_create(0,0,obj_cafe_result)
		{
			var scale = obj_cafe_time.time / obj_cafe_time.cocoatime
			if scale > 1
			{
				extrascore = floor(extrascore / scale)
			}
		}
		obj_cafe_time.markfordeath = true
		obj_dogmount.visible = true
		movespeed = abs(movespeed)
		if movespeed > 0
		{
			state = movespeed >= 12 ? states.mach3 : states.mach2
			sprite_index = state == states.mach3 ? spr_mach4 : spr_mach
		}
		else
		{
			state = states.normal
			sprite_index = spr_idle
		}
		image_index = 0
				
		with other
		{
			ds_list_add(global.saveroom, id)
			event_user(0)
		}
	}
}