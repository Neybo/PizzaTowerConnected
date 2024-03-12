if (ds_list_find_index(global.saveroom, id) == -1)
{
    if (sprite_index == spr_bigbeer)
    {
		for (var i = 0; i < sprite_get_number(spr_beerdebris); i++)
		{
			with (instance_create(x + random_range(0, sprite_width), y+ random_range(0, sprite_height),
			obj_parentparticle))
			{
				sprite_index = spr_beerdebris
				image_index = i
				vsp = irandom_range(-6, -4)
				grav = 1
				hsp = irandom_range(-4, 4)
			}
		}
    }
	for (var i = 0; i < sprite_get_number(spr_beerdebris); i++)
    {
        with (instance_create(x + random_range(0, sprite_width), y+ random_range(0, sprite_height),
		obj_parentparticle))
		{
			sprite_index = spr_beerdebris
            image_index = i
			vsp = irandom_range(-6, -4)
			grav = 1
			hsp = irandom_range(-4, 4)
		}
	}
    if (obj_player.character == "V")
        global.playerhealth = clamp((global.playerhealth + 1), 0, 100)
    global.heattime += 10
    global.heattime = clamp(global.heattime, 0, 60)
    global.combotime += 10
    global.combotime = clamp(global.combotime, 0, 60)
    with (obj_camera)
        healthshaketime = 30
    var val = heat_calculate(10)
    global.collect += val
    create_collect(x, y, spr_beerliquid)
	scr_soundeffect(sfx_beerbreak)
    with (instance_create((x + 16), y, obj_smallnumber))
        number = string(val)
    ds_list_add(global.saveroom, id)
}
