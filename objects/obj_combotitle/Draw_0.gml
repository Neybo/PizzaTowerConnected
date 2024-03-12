title_index += 0.35
if title_index >= 2
    title_index = frac(title_index)

if sugary
{
	if title >= 6
	{
		sprite_index = spr_wtfcombo_boil;
		image_speed = 0.35;
	}
}
else
	image_index = (title * 2) + title_index

paletteselect = 0
vsp -= 1
y = (obj_player.y - 15) + vsp
x = obj_player.x

if alpha > 0
    alpha -= 0.05
else
    instance_destroy()

draw_sprite_ext(sprite_index, image_index, x, y, image_xscale,
image_yscale, image_angle, image_blend, alpha)
