if sprite_index == spr_gustavo_showpizza
{
	sprite_index = spr_gustavo_givepizza;
	image_index = 0;
	
	global.showgnomelist = true;
	global.failcutscene = false;
	global.pizzadelivery = true;
	
	global.hp = 8;
	global.heattime = 60;
	
	state = states.normal;
}
