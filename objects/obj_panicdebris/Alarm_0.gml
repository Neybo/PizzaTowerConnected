if global.panic && !global.performancemode && (!instance_exists(obj_secretfound) or OLD_GAMEPLAY)
{
	var xx = 0, w = room_width, yy = 0;
	
	repeat min(round(w / 960), 8)
	{
		array_push(debris, {
			x : irandom_range(xx, w),
			y : yy + 10,
			ang : irandom_range(1, 360),
			img : irandom_range(0, 5),
			vsp : random_range(-4, 0),
			hsp : random_range(-4, 4),
		});
	}
	alarm[0] = 5;
}

