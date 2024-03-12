function scr_sprite_charsuffix(sprite, character = -1, underscore = true)
{
	if character == -1
		character = instance_exists(obj_player) ? obj_player.character : "";
	
	if character != ""
	{
		var asset = asset_get_index(sprite_get_name(sprite) + (underscore ? "_" : "") + character);
		if sprite_exists(asset)
			return asset;
	}
	return sprite;
}

