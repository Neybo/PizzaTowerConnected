mylayer = get_layer("Tiles_LAP");
if ds_list_find_index(global.saveroom, id) != -1
{
	if layer_exists(mylayer)
		layer_set_visible(mylayer, false);
	instance_destroy(id, false);
	exit;
}

if layer_exists(mylayer)
{
	layer_depth(mylayer, 90);
	layer_shader(mylayer, shd_layeralpha);
}
