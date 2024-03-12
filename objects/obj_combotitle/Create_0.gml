if global.hudtype == 0 // YOUNG MAN, KILL YOURSELF!
{
	instance_destroy()
	exit;
}
title_index = 0
title = 0
vsp = 0
alpha = 3
depth = -10
alarm[0] = 3
image_speed = 0

sugary = false;
with obj_player
{
	if character == "SP"
	{
		other.sugary = true;
		other.sprite_index = spr_comboend_titleSP;
	}
}
