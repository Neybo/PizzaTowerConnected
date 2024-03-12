if ds_list_find_index(global.saveroom, id) != -1  
	instance_destroy() 

if global.snickchallenge
	instance_destroy()

if global.gameplay != 0 && string_contains(object_get_name(content), "pizzakin") 
|| string_contains(object_get_name(content), "toppin")
{
	spr_closed = spr_toppincage;
	spr_open = spr_blankk;
}
else
{
	spr_closed = spr_pizzaboxunopen;
	spr_open = spr_pizzaboxopen;
}
sprite_index = spr_closed;
