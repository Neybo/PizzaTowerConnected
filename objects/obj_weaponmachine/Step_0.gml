if place_meeting(x, y + 8, obj_player) && obj_player.vsp < 0 && image_speed == 0
{
	if check_online() && scr_getcoin() >= price
	{
		scr_soundeffect(sfx_buyweapon)
		global.pizzacoin -= price
		image_speed = 0.35
	}
	if !check_online() && global.collect >= 40
	{
		global.collect -= 40;
		scr_soundeffect(sfx_buyweapon)
		image_speed = 0.35
	}
}
if sprite_index != spr_weaponmachine_score
	sprite_index = spr_weaponmachine_re;
if image_index >= 10
	mask_index = spr_null;

if image_speed > 0 && sprite_index == spr_weaponmachine_score && needtops > 0
{
	needtops--;
	if needtops % 2 == 0
	{
		with instance_create(OLD_GAMEPLAY ? 960 - 200 : 200, 120, obj_depositcollect)
		{
			homeinst = other.id;
			sprite_index = scr_collectsprite();
		}
	}
}
if instance_exists(obj_depositcollect) && image_index >= 8
	image_index -= 8;
if collect_shake > 0
	collect_shake = min(collect_shake * 0.5, 20);

with obj_shotgun
{
	// visually center the shotgun depending on its sprite
	if place_meeting(x, y, other)
		y = other.y - 50 + ceil((sprite_get_bbox_bottom(sprite_index) - sprite_get_bbox_top(sprite_index)) / 2);
}

