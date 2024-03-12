if (instance_exists(obj_racemenu))
{
	instance_destroy()
	exit;
}
if instance_exists(obj_pause) && obj_pause.pause
{
	instance_destroy();
	exit;
}
if (x == obj_player.x && y == obj_player.y)
	exit;
sugary = variable_map[?"sugary"];
pissino = variable_map[?"pissino"]
if point_in_camera(x, y, view_camera[0])
{
	if sugary
		scr_soundeffect(sfx_tauntSP);
	else
		scr_soundeffect_pitch((pissino) ? sfx_taunt_PP : sfx_taunt, random_range(0.9, 1.1), false);
}
