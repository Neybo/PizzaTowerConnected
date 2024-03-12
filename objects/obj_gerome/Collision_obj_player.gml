if (OLD_GAMEPLAY && !global.panic)
	exit;

ds_list_add(global.saveroom, id)
global.gerome = true;
if (OLD_GAMEPLAY)
{
	global.lap2 = true;
	scr_panictimemusic()
}
global.combotime = 60;
instance_create(x, y, obj_geromefollow)
instance_destroy()

with obj_player
{
    roomstartx = other.x
    roomstarty = other.y
}
