/// @description collect
scr_soundeffect(sfx_collectcombo);
	
instance_destroy();

create_collect(x, y, sprite_index, true);

if player && player.character == "V" 
	global.playerhealth = clamp(global.playerhealth + 1, 0, 100);

global.combotime += 10
global.combotime = clamp(global.combotime, 0, 60)

