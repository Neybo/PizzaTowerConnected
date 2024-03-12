function scr_failmod(modif)
{
	if global.modifier == modif
	{
		scr_hitthrow(noone, obj_player, 15);
		
		if modif == mods.no_toppings
			global.toppings += 1;
		global.failedmod = true;
		
		if !instance_exists(obj_pizzaface)
			instance_create(_camx + _camw / 2, _camy - 100, obj_pizzaface);
		
		with obj_drpc_updater
			event_user(3);
	}
}

