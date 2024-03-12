/// @description collect
if !variable_instance_exists(id, "snd")
	snd = sfx_collectpizza

scr_soundeffect(snd);


if object_index != obj_escapecollectbig && FINAL_GAMEPLAY
{
	if random_range(0,100) <= 33 && obj_player.character == "P"
		scr_soundeffect(sfx_pepbigcollect);
	else if random_range(0,100) <= 51 && obj_player.character == "N"
		scr_soundeffect(sfx_noisebigcollect);
	else if random_range(0,100) <= 30 && obj_player.character == "V"
		scr_soundeffect(sfx_vigibigcollect)
}

global.heattime = 60
if FINAL_GAMEPLAY
	global.combotime = 60

var val = heat_calculate(100)
global.collect += val;

with instance_create(x + 16, y, obj_smallnumber)
	number = string(val);
create_collect(x, y, sprite_index);

instance_destroy();
scr_failmod(mods.no_toppings);

tv_do_expression(spr_tv_exprcollect)
