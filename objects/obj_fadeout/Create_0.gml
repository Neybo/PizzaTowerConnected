fadealpha = 0
index = 0;
_id = noone;
pause = false

xx = 0;
yy = 0;

fadein = false
gotonoplayer = 0

if instance_exists(obj_pausefadeout)
	instance_destroy(obj_pausefadeout)

cont = true;
depth = -1000;

if (global.combo == 0)
	global.chancetogetonthatprank = false
if instance_exists(obj_roomcheck)
	instance_destroy()