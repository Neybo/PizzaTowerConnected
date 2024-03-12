var _spr = sprite_index;
if instance_exists(playerid) && playerid.character == "PP"
{
	if _spr == spr_bullet_h
		_spr = spr_shotgunbulletPP;
	if _spr == spr_bullet_v
		_spr = spr_shotgunbullet2PP;
}

draw_sprite_ext(_spr, -1, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
