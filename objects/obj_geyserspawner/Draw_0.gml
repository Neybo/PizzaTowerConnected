var geyserspr = active ? spr_geyser_active : spr_geyser_idle;

draw_sprite_part(geyserspr, img_index, 0, 0, 32, 64, x - 32, y - 64);
draw_sprite_part(geyserspr, img_index, 64, 0, 32, 64, x + sprite_width, y - 64);
for(var i = 0; i < image_xscale; i++)
	draw_sprite_part(geyserspr, img_index, 32, 0, 32, 64, x + 32 * i, y - 64);
if !active
{
	for(var i = 0; i < image_xscale + 1; i++)
	{
		if i % 3 == 0
			draw_sprite(spr_geyser_cloud, img_index, x + 32 * (i - 1), y - 64);
	}
}
img_index += 0.35;
