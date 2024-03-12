function scr_depthcheck()
{
	if place_meeting(x, y, obj_destructibles) or place_meeting(x, y, obj_metalblock)
	or place_meeting(x, y, obj_enemyblock) or place_meeting(x, y, obj_shotgunblock)
		return true;
	if place_meeting(x, y, obj_secrettile)
		depth = 91;
	return false;
}
