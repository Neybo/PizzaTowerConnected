if  ds_list_find_index(global.saveroom, id) = -1
{
	with instance_create(x+ 32,y+ 32,obj_debris)
		sprite_index =spr_bigpizzadebris
	with instance_create(x+ 32,y+ 32,obj_debris)
		sprite_index =spr_bigpizzadebris
	with instance_create(x+ 32,y+ 32,obj_debris)
		sprite_index =spr_bigpizzadebris
	with instance_create(x + 32,y+ 32,obj_debris)
		sprite_index =spr_bigpizzadebris

	scr_soundeffect(sfx_breakblock)

	ds_list_add(global.saveroom, id) 
}