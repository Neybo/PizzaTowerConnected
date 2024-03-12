/// @description collect
scr_soundeffect(sfx_collectgiantpizza);

{
	if object_index != obj_escapecollectbig && FINAL_GAMEPLAY
	{
		if random_range(0,100) <= 43 && obj_player.character == "P"
			scr_soundeffect(sfx_pepbigcollect);
		else if random_range(0,100) <= 61 && obj_player.character == "N"
			scr_soundeffect(sfx_noisebigcollect);
	}
}

var val = heat_calculate(1000)
global.collect += val;
global.combotime = 60;
with instance_create(x, y, obj_smallnumber)
	number = string(val);

if global.bullet < 3
	global.bullet += global.usebullet;
if global.ammo < 3
	global.ammo += global.useammo;

instance_destroy();
scr_failmod(mods.no_toppings);

// burst into toppings
if FINAL_GAMEPLAY
{
	var _x = x - 48;
	var _y = y - 48;
	var _xstart = _x;
	
	for (var yy = 0; yy < 4; yy++)
	{
		for (var xx = 0; xx < 4; xx++)
		{
			create_collect(_x, _y, scr_collectsprite());
			_x += 16;
		}
		_x = _xstart;
		_y += 16;
	}
}

with obj_tv
	happy_timer = 300;

