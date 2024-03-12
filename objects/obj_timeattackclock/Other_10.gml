global.timeattack = !global.timeattack;
global.taseconds = 0;
global.taminutes = 0;
global.tadecimal = 0;
scr_soundeffect(sfx_punch);
	
if global.timeattack
{
	with obj_timeattack
		newalarm = -1;
}