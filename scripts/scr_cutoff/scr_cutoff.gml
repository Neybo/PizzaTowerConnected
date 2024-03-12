function scr_cutoff()
{
	with (instance_place(x, y, obj_cutoff))
		instance_destroy();
	var dirs = [[-1, 0], [1, 0], [0, -1], [0, 1]];
	var list = ds_list_create();
	for (var i = 0; i < array_length(dirs); i++)
	{
		var d = dirs[i];
		if (!place_meeting(x + d[0], y + d[1], obj_cutoff))
		{
			
		}
		else
		{
			var num = instance_place_list(x + d[0], y + d[1], obj_cutoff, list, false);
			for (var j = 0; j < num; j++)
			{
				var b = ds_list_find_value(list, j);
				if (!is_undefined(b) && instance_exists(b))
				{
					with (b)
					{
						if (!place_meeting(x, y, obj_solid))
							instance_destroy();
						else if ((object_index != obj_cutoffsmall || other.object_index == obj_secretblock) 
						&& (object_index != obj_cutoff
						|| (other.object_index == obj_secretbigblock 
						|| other.object_index == obj_secretmetalblock)))
						{
							var a = scr_cutoff_get_angle(b);
							var da = a;
							if (d[0] < 0)
								da = 0;
							else if (d[0] > 0)
								da = 180;
							else if (d[1] < 0)
								da = 270;
							else if (d[1] > 0)
								da = 90;
							if (a == da)
								visible = true;
						}
					}
				}
			}
			ds_list_clear(list);
		}
	}
	ds_list_clear(list);
	ds_list_destroy(list);
}

function scr_cutoff_get_angle(cutoff_instance)
{
	var a = cutoff_instance.image_angle + 90;
	var d = point_direction(0, 0, lengthdir_x(1, a) * cutoff_instance.image_yscale, lengthdir_y(1, a) * cutoff_instance.image_yscale);
	return d;
}
