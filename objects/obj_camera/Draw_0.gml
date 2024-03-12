// borders
if !(instance_exists(obj_wc) && obj_wc.WC_oobcam)
{
	draw_set_color(c_black);

	draw_rectangle(-64, -64, -1, room_height + 64, false); // left
	draw_rectangle(room_width, -64, room_width + 64, room_height + 64, false); // right
	draw_rectangle(0, -64, room_width, -1, false); // top
	draw_rectangle(0, room_height, room_width, room_height + 64, false); // bottom
}

// golf camera icon
var _x, _y, _an;
while !ds_queue_empty(edge_indicator)
{
	_x = ds_queue_dequeue(edge_indicator);
	_y = ds_queue_dequeue(edge_indicator);
	_an = ds_queue_dequeue(edge_indicator);
	
	if instance_exists(player) && room != rm_darkreveal
	{
		var spr_arrow = spr_peppinoicon;
		switch player.character
		{
			case "N":
				spr_arrow = spr_noiseicon;
				break;
			case "S":
				spr_arrow = spr_snickicon;
				break;
			case "V":
				spr_arrow = spr_vigilanteicon;
				break;
			case "SP":
				spr_arrow = spr_pizzelleicon;
				break;
			case "PP":
				spr_arrow = spr_pissinoicon;
				break;
		}
		
		draw_arrow(_x, _y, _x + lengthdir_x(56, _an), _y + lengthdir_y(56, _an), 12);

		pal_swap_set(player.spr_palette, player.paletteselect, false);
		draw_sprite_ext(spr_arrow, 0, _x, _y, 1, 1, 0, c_white, 1);
		pal_swap_reset();
	}
}