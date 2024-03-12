with obj_player
{
	var m = 8;
	for(var i = 0; i < m; i++)
	{
		var s = scr_solid(x, y + i + 1, true, true);
		if s
		{
			draw_sprite_ext(spr_treasureshadow, 0, x, y + i, xscale, 1, 0, c_white, image_alpha * (1 - (i / m)));
			break;
		}
	}
}
