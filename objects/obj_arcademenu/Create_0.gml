scr_soundeffect(sfx_modmenuopen);
sel = [0, 0];
depth = -9999;

choices = [
	[
		[mods.pacifist, "Pacifist Challenge", function()
		{
			scr_soundeffect(sfx_step);
			if global.modifier == mods.pacifist
				global.modifier = -1;
			else
				global.modifier = mods.pacifist;
		}],
		[mods.no_toppings, "No Toppings Challenge", function()
		{
			scr_soundeffect(sfx_step);
			if global.modifier == mods.no_toppings
				global.modifier = -1;
			else
				global.modifier = mods.no_toppings;
		}],
		/*[3, "PIZZA CASTLE", function()
			{
				fmod_stop_all();
				room_goto(pc_load);
	        }],*/
	],
]