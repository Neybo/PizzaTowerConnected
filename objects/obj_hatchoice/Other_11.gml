if spr_idle == spr_nohat
	spr_idle = -1;

with playerid
	hatsprite = other.spr_idle;

scr_soundeffect(sfx_collecttoppin);
con = 1;

