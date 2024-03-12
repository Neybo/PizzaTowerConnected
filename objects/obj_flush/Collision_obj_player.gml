if (state == (223 << 0))
{
    state = (224 << 0)
    image_index = 0
    switch type
    {
        case 0:
            sprite_index = spr_flush_pizza
            break
        case 1:
            sprite_index = spr_flush_skull
            break
        case 2:
            sprite_index = spr_flush_rat
            break
    }
	
	var collect = heat_calculate(50);

	global.collect += collect;
	with instance_create(x + 16, y, obj_smallnumber)
		number = string(collect);

	scr_soundeffect(sfx_collecttopping);
	create_collect(x, y, sprite_index);
	
	scr_failmod(mods.no_toppings);

	if obj_player.character == "V" 
		global.playerhealth = clamp(global.playerhealth + 1, 0, 100);
	global.heattime = clamp(global.heattime + 10, 0, 60);

	if FINAL_GAMEPLAY
	{
		global.combotime += 10
		global.combotime = clamp(global.combotime, 0, 60)
	}
	instance_destroy();
}
