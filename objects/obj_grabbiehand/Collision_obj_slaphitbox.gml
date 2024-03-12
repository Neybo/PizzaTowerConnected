if !thumbingup && x == xstarte && y == ystarte && !grabbing
{
	scr_soundeffect(sfx_hitenemy)
	delay = 5
	image_xscale = -obj_player.xscale
	thumbingup = true
	instance_create(x, y, obj_bangeffect)
	sprite_index = spr_grabbiehand_hifive
	image_index = 0
}
