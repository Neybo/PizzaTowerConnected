playerid.petfollow = sel[0] - 1;
scr_soundeffect(sfx_collecttoppin);
con = 1;

if playerid.petfollow > -1 && !instance_exists(obj_petfollow)
	instance_create(playerid.x, playerid.y, obj_petfollow);
else if playerid.petfollow < 0 && instance_exists(obj_petfollow)
	instance_destroy(obj_petfollow);