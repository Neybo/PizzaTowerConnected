if sprite_index == spr_ufogrounded_bullet && REMIX_GAMEPLAY
{
	with instance_create(x, y, obj_cloudeffect)
		sprite_index = spr_ufogrounded_bulletdestroy;
}
