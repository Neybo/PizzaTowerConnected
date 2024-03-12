if !active
{
	var player = instance_place(x, y - 1, obj_player);
	if player && 
	(player.sprite_index == player.spr_bodyslamland || player.sprite_index == player.spr_poundcancel2)
	{
		scr_soundeffect(sfx_geyser);
		active = true;
		
		verticalid = instance_create(x, y, obj_geyservertical);
		with verticalid
			image_xscale = other.image_xscale;
	}
}
else
{
	if !instance_exists(verticalid)
		active = false;
}
