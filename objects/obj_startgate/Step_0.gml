drawing = place_meeting(x, y, obj_player)
if !computer
	scr_hub_bg_step()
if place_meeting(x, y, obj_player)
{
	// rematch comuter flicker
	if computer == 3
		image_index = choose(0, 0, 0, 0, 0, 0, 0, 1);
	else if computer == 4
		image_speed = 0.35;
	else
		image_speed = 0;
}
else
{
	image_speed = 0
	image_index = 0
}
if sprite_index == spr_exitgate
	image_index = 1;

// show level name when player near
if instance_exists(obj_player)
{
	var p = instance_nearest(x, y, obj_player);
	
	if msg != "" && distance_to_object(p) < 50
	&& p.state != states.gameover && p.state != states.victory
	{
		with obj_tv
		{
			message = other.msg
			showtext = true
			alarm[2] = 2
		}
	}
}
if !computer
{
if (!drawing)
{
    var dis = 250
    bgalpha = (distance_to_object(obj_player) / dis)
    bgalpha -= 0.25
    if (bgalpha > 1)
        bgalpha = 1
    if (bgalpha < 0)
        bgalpha = 0
}
else
    bgalpha = Approach(bgalpha, 0, 0.1)
}
else
{
if (!drawing)
{
    var dis = 250
    bgalpha = clamp(1 -(distance_to_object(obj_player) / dis), 0, 1)
    bgalpha -= 0.25
    if (bgalpha > 1)
        bgalpha = 1
    if (bgalpha < 0)
        bgalpha = 0
}
else
    bgalpha = Approach(bgalpha, 0.9, 1)
}