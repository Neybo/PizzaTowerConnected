if done
{
	image_yscale = Approach(image_yscale, 0, 0.5);
	image_alpha -= 0.05;
	
	if image_alpha <= 0
		instance_destroy();
}
else
{
	if !place_meeting(x, y, obj_geyserstop)
	{
		image_yscale -= 1;
		if place_meeting(x, y, obj_geyserstop)
			alarm[0] = room_speed * 5;
	}
}

var player = instance_place(x, y, obj_player);
if player
{
	player.vsp = -clamp(lerp(0, 64, (player.y - bbox_bottom) / sprite_height), 4, 18);
	player.state = states.geyser;
	player.sprite_index = player.spr_geyser;
}

