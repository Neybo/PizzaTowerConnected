/// @description collect
var collect = heat_calculate(10);

scr_soundeffect(sfx_collecttoppin);
create_collect(obj_player.x, obj_player.y, scr_collectsprite(),,true);
global.collect += collect
scoredone += collect
if obj_player.character == "V" 
	global.playerhealth = clamp(global.playerhealth + 1, 0, 100);
global.heattime = clamp(global.heattime + 10, 0, 60);

if FINAL_GAMEPLAY
{
	global.combotime += 10
	global.combotime = clamp(global.combotime, 0, 60)
}

if scoredone < extrascore
	alarm[1] = floor(240 / extrascore * 10)